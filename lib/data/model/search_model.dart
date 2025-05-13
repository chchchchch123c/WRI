class SearchModel {
  final bool state;
  final int dataNum;
  final List<Data> data;
  final String? error;

  SearchModel({required this.state, required this.dataNum, required this.data, required this.error});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      state: json['state'] ?? false,
      dataNum: json['dataNum'] ?? 0,
      data: (json['data'] as List<dynamic>?)?.map((e) => Data.fromJson(e)).toList() ?? [],
      error: json['error'] ?? '',
    );
  }
}

class Data {
  final String continent_nm;
  final String country_nm;
  final String flag_url;
  final String country_code;
  final int alarm_level;

  Data({
    required this.continent_nm,
    required this.country_nm,
    required this.flag_url,
    required this.country_code,
    required this.alarm_level,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      continent_nm: json['continent_nm'] ?? '',
      country_nm: json['country_nm'] ?? '',
      flag_url: json['flag_url'] ?? '',
      country_code: json['country_code'] ?? '',
      alarm_level: json['alarm_level'] ?? 0,
    );
  }
}
