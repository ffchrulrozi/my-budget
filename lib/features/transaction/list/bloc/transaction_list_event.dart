import 'package:equatable/equatable.dart';

abstract class TransactionListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Init extends TransactionListEvent {}

class LoadTransactions extends TransactionListEvent {}

class DeleteTransaction extends TransactionListEvent {
  final int id;
  DeleteTransaction(this.id);
}

class FilterChange extends TransactionListEvent {
  final DateTime? date;
  final int? typeId;
  FilterChange({this.date, this.typeId});
}

class LoadTypes extends TransactionListEvent {}
