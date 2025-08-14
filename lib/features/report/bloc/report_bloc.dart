import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/data/drift/app_database.dart';
import 'package:my_budget/data/drift/daos/category_dao.dart';
import 'package:my_budget/data/drift/daos/type_dao.dart';
import 'package:my_budget/features/report/bloc/report_event.dart';
import 'package:my_budget/features/report/bloc/report_state.dart';
import 'package:my_budget/main.dart';
import 'package:my_budget/utils/ext/date_ext.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final AppDatabase db = getIt<AppDatabase>();
  final TypeDao typeDao = getIt<TypeDao>();
  final CategoryDao categoryDao = getIt<CategoryDao>();

  ReportBloc() : super(ReportState()) {
    on<Init>(_Init);
    on<LoadReports>(_LoadReports);
    on<LoadTypes>(_LoadTypes);
    on<FilterChange>(_FilterChange);

    add(Init());
  }

  Future<List<CategoryResult>> _getCategories() async {
    final t = db.alias(db.transactions, 't');
    final c = db.alias(db.categories, 'c');
    final sum = t.amount.sum();
    final avg = t.amount.avg();

    final query = db.selectOnly(t)
      ..addColumns([c.name, c.icon, sum, avg])
      ..join([innerJoin(c, c.id.equalsExp(t.categoryId))])
      ..where(t.date.isBiggerOrEqualValue(state.filter!.startDate!))
      ..where(t.date.isSmallerOrEqualValue(state.filter!.endDate!))
      ..where(t.typeId.equals(state.filter!.typeId!))
      ..groupBy([c.name]);

    final results = await query
        .map((row) => CategoryResult(
              icon: row.read(c.icon),
              categoryName: row.read(c.name),
              amount: row.read(sum),
              percent: row.read(avg),
            ))
        .get();

    return results;
  }

  Future<Summary> _getSummary() async {
    final t = db.alias(db.transactions, 't');
    final sum = t.amount.sum();

    final outcome = await (db.selectOnly(t)
          ..addColumns([sum])
          ..where(t.date.isBiggerOrEqualValue(state.filter!.startDate!))
          ..where(t.date.isSmallerOrEqualValue(state.filter!.endDate!))
          ..where(t.typeId.equals(1)))
        .map((row) => row.read(sum) ?? 0)
        .getSingle();

    final income = await (db.selectOnly(t)
          ..addColumns([sum])
          ..where(t.date.isBiggerOrEqualValue(state.filter!.startDate!))
          ..where(t.date.isSmallerOrEqualValue(state.filter!.endDate!))
          ..where(t.typeId.equals(2)))
        .map((row) => row.read(sum) ?? 0)
        .getSingle();

    return Summary(outcome, income);
  }

  _Init(event, emit) async {
    emit(state.copyWith(
      filter: Filter(
        dateType: FilterDateType.LAST7DAYS,
        startDate: DateTime.now().add(Duration(days: -7)).toStartOfDay(),
        endDate: DateTime.now().toEndOfDay(),
        typeId: 1,
      ),
    ));

    await _LoadReports(event, emit);
    await _LoadTypes(event, emit);
  }

  _LoadReports(event, emit) async {
    emit(state.copyWith(isLoading: true));

    emit(state.copyWith(
      categories: await _getCategories(),
      summary: await _getSummary(),
      isLoading: false,
    ));
  }

  _LoadTypes(event, emit) async {
    final types = await typeDao.getAll();
    emit(state.copyWith(types: types));
  }

  _FilterChange(FilterChange event, Emitter<ReportState> emit) async {
    if (event.typeId != null) {
      final filter = state.filter?.copyWith(typeId: event.typeId);
      emit(state.copyWith(filter: filter));
    }
    if (event.dateType != null) {
      DateTime startDate = DateTime.now().toStartOfDay();
      DateTime endDate = DateTime.now().toEndOfDay();

      switch (event.dateType) {
        case FilterDateType.LAST7DAYS:
          startDate = startDate.add(Duration(days: -7));
          break;
        case FilterDateType.THISMONTH:
          startDate = startDate.toStartOfMonth();
          break;
        case FilterDateType.LAST30DAYS:
          startDate = startDate.add(Duration(days: -30));
          break;
        case FilterDateType.CUSTOM:
          if (state.filter?.startDate != null) {
            startDate = state.filter!.startDate!.toStartOfDay();
          }
          if (state.filter!.endDate != null) {
            endDate = state.filter!.endDate!.toEndOfDay();
          }
          break;
      }

      final filter = state.filter?.copyWith(
        dateType: event.dateType,
        startDate: startDate,
        endDate: endDate,
      );

      emit(state.copyWith(filter: filter));
    }
    add(LoadReports());
  }
}
