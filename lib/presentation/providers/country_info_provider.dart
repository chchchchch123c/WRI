import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wri/common/color.dart';
import 'package:wri/common/string.dart';
import 'package:wri/data/model/country_info_model.dart';
import 'package:wri/data/service/country_info_service.dart';

CountryInfoProvider countryInfoProvider = CountryInfoProvider(CountryInfoService());

class CountryInfoProvider extends ChangeNotifier {

  String capitalCityImage = '';

  bool isTextOverFlow = false;

  String nowH1 = '0';
  String nowH2 = '0';
  String nowM1 = '0';
  String nowM2 = '0';

  String utcH1 = '0';
  String utcH2 = '0';
  String utcM1 = '0';
  String utcM2 = '0';

  CountryInfoModel? countryInfoModel;
  final CountryInfoService service;
  CountryInfoProvider(this.service);

  Future<void> loadCountryInfoModel() async {
    final res = await service.postCountryInfoModel(country: currentCountry!);
    countryInfoModel = res;
    final randomValue = countryInfoModel?.data.random;

    if (countryInfoModel?.data.info.climate == '') {
      List<String> climates = [
        '은(는) 대체로 좋은 기후를 가지고 있어요.',
        '은(는) 대체로 나쁜 기후를 가지고 있어요.',
        '은(는) 대체로 더운 기후를 가지고 있어요.',
        '은(는) 대체로 추운 기후를 가지고 있어요.',
      ];

      String selectedClimate;

      switch (randomValue) {
        case '1':
          selectedClimate = climates[0];
          break;
        case '2':
          selectedClimate = climates[1];
          break;
        case '3':
          selectedClimate = climates[2];
          break;
        case '4':
          selectedClimate = climates[3];
          break;
        default:
          selectedClimate = '은(는) 대체로 다양한 기후를 가지고 있어요.';
      }

      countryInfoModel?.data.info.climate = '${countryInfoModel?.data.country_name}$selectedClimate';
      notifyListeners();
    }

    countryInfoModel?.data.random;
    if (countryInfoModel?.data.info.currency == '') {
      countryInfoModel?.data.info.currency = '원(KRW) ⇔ 달러(USD)';
      notifyListeners();
    }
    if (countryInfoModel?.data.info.religion == '') {
      countryInfoModel?.data.info.religion = '${countryInfoModel?.data.country_name}은(는) 개신교가 42 %를 차지 하고 있어요.';
      notifyListeners();
    }
    if (countryInfoModel?.data.info.capitalCity == '') {
      countryInfoModel?.data.info.capitalCity = '${countryInfoModel?.data.country_name}의 수도는 문화의 중심지에요.';
      notifyListeners();
    }
    if (countryInfoModel?.data.info.area == '') {
      countryInfoModel?.data.info.area = '${countryInfoModel?.data.country_name}의 면적은 대한미국의 2배 정도에요.';
      notifyListeners();
    }
    if (countryInfoModel?.data.info.location == '') {
      countryInfoModel?.data.info.location = '${countryInfoModel?.data.country_name}은(는) 두 국가와 국경을 마주 하고 있어요.';
      notifyListeners();
    }
    if (countryInfoModel?.data.info.population == '') {
      countryInfoModel?.data.info.population = '${countryInfoModel?.data.country_name}의 인구 수는 대한민국의 1.2배 정도에요.';
      notifyListeners();
    }
    countryInfoModel = res;

    if (countryInfoModel?.data.info.time == '') {
      countryInfoModel?.data.info.time = 'UTC +0';
      notifyListeners();
    }

    DateTime now = DateTime.now().toLocal();
    DateTime utc = DateTime.now().toUtc();
    final formatted = DateFormat('HH:mm').format(now);
    final utcFormatted = DateFormat('HH:mm').format(utc);

    final parts = formatted.split(':');
    final hour = parts[0].padLeft(2, '0');
    final minute = parts[1].padLeft(2, '0');

    final utcParts = utcFormatted.split(':');
    final utcHour = utcParts[0].padLeft(2, '0');
    final utcMinute = utcParts[1].padLeft(2, '0');

    utcH1 = utcHour[0];
    utcH2 = utcHour[1];
    utcM1 = utcMinute[0];
    utcM2 = utcMinute[1];

    nowH1 = hour[0];
    nowH2 = hour[1];
    nowM1 = minute[0];
    nowM2 = minute[1];

    List<String> capitalCity = [
      'assets/capital_city/capital_city1.jpg',
      'assets/capital_city/capital_city2.png',
      'assets/capital_city/capital_city3.jpg',
      'assets/capital_city/capital_city4.jpg',
    ];

    String selectedCapitalCity;

    switch (randomValue) {
      case '1':
        selectedCapitalCity = capitalCity[0];
      case '2':
        selectedCapitalCity = capitalCity[1];
      case '3':
        selectedCapitalCity = capitalCity[2];
      case '4':
        selectedCapitalCity = capitalCity[3];
      default:
        selectedCapitalCity = 'assets/capital_city/capital_city1.jpg';
    }
    capitalCityImage = selectedCapitalCity;

    notifyListeners();
  }

  Color levelColor = level1Color;
  String levelText = '이 지역은 여행이 가능하지만, 신중하게 상황을 살피며 유의해 주세요.';

  final List<Color> levelColorList = [
    level1Color,
    level2Color,
    level3Color,
    level4Color,
  ];

  final List<String> levelTextList = [
    '이 지역은 여행이 가능하지만, 신중하게 상황을 살피며 유의해 주세요.',
    '이 곳은 국가 전역이 조금 주의가 필요해요.',
    '현재 상황이 위험해요. 해당 지역에 체류 중이라면 즉시 철수를 검토해 주세요.',
    '이 지역은 매우 위험해요. 여행이 금지되어 있으며, 방문을 삼가 주세요.',
  ];

  int getLevelColorIndex(int level) {
    switch (level) {
      case 1: return 0;
      case 2: return 1;
      case 3: return 2;
      case 4: return 3;
      default : {
        return 0;
      }
    }
  }
}