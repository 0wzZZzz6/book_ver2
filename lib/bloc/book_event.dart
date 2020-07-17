part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();
}

class FetchBooks extends BookEvent {
  final String query;
  final Map<String, dynamic> variables;

  FetchBooks(this.query, {this.variables});

  @override
  List<Object> get props => [query, variables];
}
