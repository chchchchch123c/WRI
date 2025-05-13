class CountryInfoModel {
  final bool state;
  final Data data;

  CountryInfoModel({required this.state, required this.data});

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    return CountryInfoModel(
      state: json['state'] ?? false,
      data: Data.fromJson(json['data'] ?? {}),
    );
  }
}

class Data {
  final String country_name;
  final String flag_url;
  final String dang_map_download_url;
  final String continent;
  final String extract;
  final int alarm_level;
  final Info info;
  final String weather;
  final String exchange_rate;
  final String random;

  Data({
    required this.country_name,
    required this.flag_url,
    required this.dang_map_download_url,
    required this.continent,
    required this.extract,
    required this.alarm_level,
    required this.info,
    required this.weather,
    required this.exchange_rate,
    required this.random,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      country_name: json['country_name'] ?? '',
      flag_url: json['flag_url'] ?? '',
      dang_map_download_url: json['dang_map_download_url'] ?? '',
      continent: json['continent'] ?? '',
      extract: json['extract'] ?? '',
      alarm_level: json['alarm_level'] ?? 0,
      info: Info.fromJson(json['info'] ?? {}),
      weather: json['weather'] ?? '',
      exchange_rate: json['exchange_rate'] ?? '',
      random: json['random'] ?? '',
    );
  }
}

class Info {
  final String countryName; // 완료
  late String location; // 완료
  late String population; // 완료
  late String climate; // 완료
  late String area; // 완료
  late String capitalCity;
  late String language; // 완료
  late String religion; // 완료
  late String time; // 완료
  late String currency; // 완료

  Info({
    required this.countryName,
    required this.location,
    required this.population,
    required this.climate,
    required this.area,
    required this.capitalCity,
    required this.language,
    required this.religion,
    required this.time,
    required this.currency,
  });

  factory Info.fromJson(dynamic rawJson) {
    final info = (rawJson ?? {}) as Map<String, dynamic>;
    return Info(
      countryName: info['국명'] ?? info['공식 국명'] ?? info['정식명칭'] ?? info['국호'] ?? '',
      location: info['위치'] ?? '',
      population: info['인구'] ?? '',
      climate: info['기후'] ?? '',
      area: info['면적'] ?? info['총면적'] ?? '',
      capitalCity: info['수도'] ?? '',
      language: info['언어'] ?? info['공용어'] ?? '',
      religion: info['종교'] ?? '',
      time: info['시차'] ?? info['시간대'] ?? info['표준시'] ?? '',
      currency: info['화폐'] ?? info['통화'] ?? info['화폐단위'] ?? info['통화단위'] ?? info['통화 단위'] ?? '',
    );
  }
}

