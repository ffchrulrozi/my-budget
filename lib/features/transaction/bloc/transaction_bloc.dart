import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/daos/category_dao.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/transaction/bloc/transaction_event.dart';
import 'package:my_budget/features/transaction/bloc/transaction_state.dart';
import 'package:my_budget/main.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    final AppDatabase db = getIt<AppDatabase>();
    final TypeDao typeDao = getIt<TypeDao>();
    final CategoryDao categoryDao = getIt<CategoryDao>();

    on<LoadTransactions>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final income = await (db.selectOnly(db.transactions)
            ..addColumns([db.transactions.amount.sum()])
            ..where(db.transactions.typeId.equals(2)))
          .map((row) => row.read(db.transactions.amount.sum()) ?? 0)
          .getSingle();

      final outcome = await (db.selectOnly(db.transactions)
            ..addColumns([db.transactions.amount.sum()])
            ..where(db.transactions.typeId.equals(1)))
          .map((row) => row.read(db.transactions.amount.sum()) ?? 0)
          .getSingle();

      final summary = Summary(income, outcome);
      final t = db.alias(db.transactions, 'p');
      final c = db.alias(db.categories, 'c');

      final query =
          db.select(t).join([innerJoin(c, c.id.equalsExp(t.categoryId))]);

      final transactions = await query.map((row) {
        return TransactionListResult(
          id: row.read(t.id)!,
          date: row.read(t.date)!,
          title: row.read(t.title)!,
          desc: row.read(t.desc)!,
          amount: row.read(t.amount)!,
          categoryName: row.read(c.name)!,
          icon: row.read(c.icon)!,
        );
      }).get();

      emit(state.copyWith(
        transactions: transactions,
        summary: summary,
        isLoading: false,
      ));
    });

    on<CreateTransaction>((event, emit) async {
      await db.into(db.transactions).insert(TransactionsCompanion.insert(
            date: Value(event.date),
            title: event.title,
            desc: event.desc,
            amount: event.amount,
            typeId: Value(event.typeId),
            categoryId: Value(event.categoryId),
          ));

      add(LoadTransactions());
      emit(state.copyWith(isSaved: true));
    });

    on<UpdateTransaction>((event, emit) async {
      await (db.update(db.transactions)..where((t) => t.id.equals(event.id)))
          .write(TransactionsCompanion(
        date: Value(event.date),
        title: Value(event.title),
        desc: Value(event.desc),
        amount: Value(event.amount),
        typeId: Value(event.typeId),
        categoryId: Value(event.categoryId),
      ));

      emit(state.copyWith(isSaved: true));
    });

    on<DeleteTransaction>((event, emit) async {
      await (db.delete(db.transactions)..where((t) => t.id.equals(event.id)))
          .go();
      add(LoadTransactions());
    });

    on<LoadTypes>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final types = await typeDao.getAll();
      emit(state.copyWith(types: types, isLoading: false));
    });

    on<TypeChanged>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final categories = await categoryDao.getByType(event.typeId);
      emit(state.copyWith(categories: categories, isLoading: false));
    });
  }
}