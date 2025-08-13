import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/daos/category_dao.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/transaction/add/bloc/transaction_add_event.dart';
import 'package:my_budget/features/transaction/add/bloc/transaction_add_state.dart';
import 'package:my_budget/main.dart';
import 'package:my_budget/utils/ext/date_ext.dart';

class TransactionAddBloc
    extends Bloc<TransactionAddEvent, TransactionAddState> {
  TransactionAddBloc() : super(const TransactionAddState()) {
    final AppDatabase db = getIt<AppDatabase>();
    final TypeDao typeDao = getIt<TypeDao>();
    final CategoryDao categoryDao = getIt<CategoryDao>();

    on<CreateTransaction>((event, emit) async {
      await db.into(db.transactions).insert(TransactionsCompanion.insert(
            date: Value(event.date.toStartOfDay()),
            title: event.title,
            desc: event.desc,
            amount: event.amount,
            typeId: Value(event.typeId),
            categoryId: Value(event.categoryId),
          ));

      // add(LoadTransactions());
      emit(state.copyWith(isSaved: true));
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
