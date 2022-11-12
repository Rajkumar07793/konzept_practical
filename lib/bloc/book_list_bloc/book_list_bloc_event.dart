import 'package:equatable/equatable.dart';

class BookListBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookListEvent extends BookListBlocEvent {
  final DateTime date;
  BookListEvent(this.date);
  @override
  List<Object?> get props => [date];
}
