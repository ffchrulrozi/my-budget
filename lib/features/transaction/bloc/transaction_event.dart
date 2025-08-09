import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class CreateTransaction extends TransactionEvent {
  final DateTime date;
  final String title;
  final String desc;
  final int amount;
  final int typeId;
  final int categoryId;

  CreateTransaction(
    this.date,
    this.title,
    this.desc,
    this.amount,
    this.typeId,
    this.categoryId,
  );
}

class UpdateTransaction extends TransactionEvent {
  final int id;
  final DateTime date;
  final String title;
  final String desc;
  final int amount;
  final int typeId;
  final int categoryId;

  UpdateTransaction(
    this.id,
    this.date,
    this.title,
    this.desc,
    this.amount,
    this.typeId,
    this.categoryId,
  );
}

class DeleteTransaction extends TransactionEvent {
  final int id;
  DeleteTransaction(this.id);
}

class LoadTypes extends TransactionEvent {}

class TypeChanged extends TransactionEvent {
  final int typeId;
  TypeChanged(this.typeId);
}
