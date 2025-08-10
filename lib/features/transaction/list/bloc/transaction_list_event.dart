import 'package:equatable/equatable.dart';

abstract class TransactionListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionListEvent {}

class DeleteTransaction extends TransactionListEvent {
  final int id;
  DeleteTransaction(this.id);
}

class LoadTypes extends TransactionListEvent {}

class FilterChanged extends TransactionListEvent {
  final DateTime? date;
  final int? typeId;
  FilterChanged({this.date, this.typeId});
}
