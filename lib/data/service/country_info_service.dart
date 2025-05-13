import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:wri/common/string.dart';

import '../model/country_info_model.dart';

class CountryInfoService {

  final client = Client();

  Future<CountryInfoModel?> postCountryInfoModel({required String country}) async {
    try {

      final header = {
        "Content-Type": "application/json"
      };

      final body = jsonEncode({
        "iso": country,
        "secretKey": "5\$OyAt9dy2QS95pg"
      });

      final response = await client.post(Uri.parse('$url/api/infoData/'), headers: header, body: body);

      if (response.statusCode != 200) {
        log('response is not 200 : ${response.statusCode}');
        return null;
      }

      final json = jsonDecode(response.body);
      final jsonBody = CountryInfoModel.fromJson(json);

      return jsonBody;

    } catch (e, t) {
      log('postCountryInfoModel', error: e, stackTrace: t);
      return null;
    }
  }

}