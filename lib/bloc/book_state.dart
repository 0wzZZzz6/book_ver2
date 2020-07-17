part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();
}

class BookInitial extends BookState {
  @override
  List<Object> get props => [];
}

class BookLoading extends BookState {
  BookLoading() : super();

  @override
  List<Object> get props => [];
}

class BookDataSuccess extends BookState {
  final dynamic data;

  BookDataSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}

class BookDataFail extends BookState {
  final dynamic error;

  BookDataFail(this.error) : super();

  @override
  List<Object> get props => [error];
}
