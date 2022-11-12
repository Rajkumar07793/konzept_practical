import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konzept_practical/bloc/book_list_bloc/book_list_bloc.dart';
import 'package:konzept_practical/bloc/book_list_bloc/book_list_bloc_event.dart';
import 'package:konzept_practical/bloc/book_list_bloc/book_list_bloc_state.dart';
import 'package:konzept_practical/globals/widgets/loader.dart';
import 'package:konzept_practical/services/api/get_book_list.dart';
import 'package:konzept_practical/views/login.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime? selectedDay;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _focusedDay;

  Future<BookListResponse>? getBookListApi;

  var bookListBloc = BookListBloc(BookListBlocInitialState());

  @override
  void initState() {
    bookListBloc.add(BookListEvent(DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder(
            bloc: bookListBloc,
            builder: (context, state) {
              if (state is BookListState) {
                var dates = state.bookListResponse.date;
                return TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay:
                      _focusedDay != null ? _focusedDay! : DateTime.now(),
                  currentDay:
                      selectedDay != null ? selectedDay! : DateTime.now(),
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                    bookListBloc.add(BookListEvent(focusedDay));
                  },
                  onDaySelected: onDaySelected,
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      for (var bookedDate in dates) {
                        if (DateTime.parse(day.toString().split(' ')[0])
                            .isAtSameMomentAs(bookedDate.date)) {
                          return InkWell(
                            onTap: () {
                              print('disabled');
                            },
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          );
                        }
                      }
                      return null;
                    },
                  ),
                );
              }
              if (state is BookListBlocErrorState) {
                return TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay:
                        _focusedDay != null ? _focusedDay! : DateTime.now(),
                    currentDay:
                        selectedDay != null ? selectedDay! : DateTime.now(),
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                      bookListBloc.add(BookListEvent(focusedDay));
                    },
                    onDaySelected: onDaySelected);
              }
              return loader();
            }),
      ),
    );
  }

  void onDaySelected(DateTime selectedDay1, DateTime focusedDay) {
    setState(() {
      selectedDay = selectedDay1;
      _focusedDay = focusedDay;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }
}
