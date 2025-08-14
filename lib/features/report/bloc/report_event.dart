abstract class ReportEvent {}

class Init extends ReportEvent {}

class LoadReports extends ReportEvent {}

class LoadTypes extends ReportEvent {}

class FilterChange extends ReportEvent {
  final String? dateType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? typeId;
  FilterChange({this.dateType, this.startDate, this.endDate, this.typeId});
}
