import 'package:book_ver2/bloc/book_bloc.dart';
import 'package:book_ver2/bloc/simple_bloc_observer.dart';
import 'package:book_ver2/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'graphql_operation/queries.dart' as queries;

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<BookBloc>(
          create: (BuildContext context) =>
              BookBloc()..add(FetchBooks(queries.books)),
          child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data = List();

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('GraphQL Demo'),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          title: Text(data[index]['name']),
          subtitle: Text('id #${data[index]['id'].toString()}'),
        ),
        itemCount: data.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      if (state is BookLoading) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: LinearProgressIndicator(),
        );
      } else if (state is BookDataFail) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: Center(
            child: Text(state.error),
          ),
        );
      } else {
        data = (state as BookDataSuccess).data['books'];
        print(data[0]['name']);
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        );
      }
    });
  }
}
