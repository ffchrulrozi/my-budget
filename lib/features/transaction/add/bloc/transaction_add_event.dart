import 'package:equatable/equatable.dart';

abstract class TransactionAddEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTransaction extends TransactionAddEvent {
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

class LoadTypes extends TransactionAddEvent {}

class TypeChanged extends TransactionAddEvent {
  final int typeId;
  TypeChanged(this.typeId);
}
