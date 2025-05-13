import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:wri/common/string.dart';

import '../model/search_model.dart';

class SearchService {

  final client = Client();

  Future<SearchModel?> postSearch({required String country}) async {
    try {

      final header = {
        "Content-Type": "application/json"
      };

      final body = jsonEncode({
        "searchData": country,
        "secretKey": "5\$OyAt9dy2QS95pg"
      });

      final response = await client.post(Uri.parse('$url/api/search/'), headers: header, body: body);

      final json = jsonDecode(response.body);
      final jsonBody = SearchModel.fromJson(json);

      return jsonBody;

    } catch (e, t) {
      log('postSearch', error: e, stackTrace: t);
      return null;
    }
  }

}