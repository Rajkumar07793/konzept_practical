import 'package:equatable/equatable.dart';
import 'package:konzept_practical/services/api/get_book_list.dart';

class BookListBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookListBlocInitialState extends BookListBlocState {}

class BookListBlocLoadingState extends BookListBlocState {}

class BookListBlocErrorState extends BookListBlocState {}

class BookListState extends BookListBlocState {
  final BookListResponse bookListResponse;
  BookListState(this.bookListResponse);
  @override
  List<Object?> get props => [bookListResponse];
}
