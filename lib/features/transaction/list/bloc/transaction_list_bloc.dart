import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_event.dart';
import 'package:my_budget/features/transaction/list/bloc/transaction_list_state.dart';
import 'package:my_budget/main.dart';
import 'package:my_budget/utils/ext/date_ext.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final AppDatabase db = getIt<AppDatabase>();
  final TypeDao typeDao = getIt<TypeDao>();

  TransactionListBloc() : super(const TransactionListState()) {
    on<Init>(_Init);
    on<LoadTransactions>(_LoadTransactions);
    on<DeleteTransaction>(_DeleteTransaction);
    on<LoadTypes>(_LoadTypes);
    on<FilterChange>(_FilterChange);

    add(Init());
  }

  Future<Summary> getSummary() async {
    final outcome = await (db.selectOnly(db.transactions)
          ..addColumns([db.transactions.amount.sum()])
          ..where(db.transactions.date.equals(state.filter!.date!))
          ..where(db.transactions.typeId.equals(1)))
        .map((row) => row.read(db.transactions.amount.sum()) ?? 0)
        .getSingle();

    final income = await (db.selectOnly(db.transactions)
          ..addColumns([db.transactions.amount.sum()])
          ..where(db.transactions.date.equals(state.filter!.date!))
          ..where(db.transactions.typeId.equals(2)))
        .map((row) => row.read(db.transactions.amount.sum()) ?? 0)
        .getSingle();

    return Summary(outcome, income);
  }

  Future<List<TransactionListResult>> getTransactions() async {
    final t = db.alias(db.transactions, 'p');
    final c = db.alias(db.categories, 'c');
    final query =
        db.select(t).join([innerJoin(c, c.id.equalsExp(t.categoryId))])
          ..where(t.date.equals(state.filter!.date!))
          ..where(t.typeId.equals(state.filter!.typeId!));

    return await query.map((row) {
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
  }

  _Init(event, emit) async {
    emit(state.copyWith(
        filter: Filter(date: DateTime.now().toStartOfDay(), typeId: 1)));

    await _LoadTransactions(event, emit);
    await _LoadTypes(event, emit);
  }

  _LoadTransactions(event, emit) async {
    emit(state.copyWith(isLoading: true));

    emit(state.copyWith(
      transactions: await getTransactions(),
      summary: await getSummary(),
      isLoading: false,
    ));
  }

  _DeleteTransaction(event, emit) async {
    await (db.delete(db.transactions)..where((t) => t.id.equals(event.id)))
        .go();
    add(LoadTransactions());
  }

  _FilterChange(FilterChange event, emit) async {
    var filter = state.filter;
    if (event.date != null) {
      filter = filter?.copyWith(date: event.date!.toStartOfDay());
    }
    if (event.typeId != null) {
      filter = filter?.copyWith(typeId: event.typeId);
    }
    emit(state.copyWith(filter: filter));
    add(LoadTransactions());
  }

  _LoadTypes(event, emit) async {
    final types = await typeDao.getAll();
    emit(state.copyWith(types: types));
  }
}
