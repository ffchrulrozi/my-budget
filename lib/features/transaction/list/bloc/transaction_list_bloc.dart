import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_event.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_state.dart';
import 'package:my_budget/main.dart';

class TransactionListBloc extends Bloc<TransactionListEvent, TransactionListState> {
  TransactionListBloc() : super(const TransactionListState()) {
    final AppDatabase db = getIt<AppDatabase>();
    final TypeDao typeDao = getIt<TypeDao>();

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

    on<FilterChanged>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      // final categories = await categoryDao.getByType(event.typeId);
      // emit(state.copyWith(categories: categories, isLoading: false));
    });
  }
}