import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konzept_practical/bloc/book_list_bloc/book_list_bloc_event.dart';
import 'package:konzept_practical/bloc/book_list_bloc/book_list_bloc_state.dart';
import 'package:konzept_practical/services/api/get_book_list.dart';

class BookListBloc extends Bloc<BookListBlocEvent, BookListBlocState> {
  BookListBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      BookListBlocEvent event, Emitter<BookListBlocState> emit) async {
    if (event is BookListEvent) {
      await getBookList(event.date)
          .then((value) => emit(BookListState(value)))
          .onError((error, stackTrace) => emit(BookListBlocErrorState()));
    }
  }
}
