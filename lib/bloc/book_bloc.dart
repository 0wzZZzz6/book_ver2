import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_ver2/models/book.dart';
import 'package:book_ver2/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  AppRepository appRepository;

  BookBloc() : super(BookLoading()) {
    appRepository = AppRepository();
  }

  @override
  Stream<BookState> mapEventToState(
    BookEvent event,
  ) async* {
    if (event is FetchBooks) {
      yield* _mapFetchBooksToStates(event);
    }
  }

  Stream<BookState> _mapFetchBooksToStates(FetchBooks event) async* {
    final query = event.query;
    final variables = event.variables ?? null;

    try {
      final result =
          await appRepository.performQuery(query, variables: variables);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception.graphqlErrors.toString()}');
        print('clientErrors: ${result.exception.clientException.toString()}');
        yield BookDataFail(result.data);
      } else {
        yield BookDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield BookDataFail(e.toString());
    }
  }
}
