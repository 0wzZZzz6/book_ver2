import 'package:graphql/client.dart';

class AppRepository {
  static final HttpLink _httpLink =
      HttpLink(uri: 'http://039f20fd7728.ngrok.io/graphql');

  static final GraphQLClient _client = GraphQLClient(
      link: _httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject));

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic> variables}) async {
    final WatchQueryOptions _options =
        WatchQueryOptions(documentNode: gql(query), variables: variables);

    return _client.query(_options);
  }
}
