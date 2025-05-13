import 'package:flutter/material.dart';
import 'package:wri/common/string.dart';
import 'package:wri/data/model/search_model.dart';
import 'package:wri/data/service/search_service.dart';
import 'package:wri/presentation/screens/country_info.dart';

HomeProvider homeProvider = HomeProvider(SearchService());

class HomeProvider extends ChangeNotifier {

  TextEditingController searchCountryController = TextEditingController(text: '');

  SearchModel? searchModel;
  final SearchService searchService;
  HomeProvider(this.searchService);

  bool isSafe = false;

  Future<void> loadSearchData() async {
    final searchData = await searchService.postSearch(country: searchCountryController.text);
    if (searchData == null)return;
    searchModel = searchData;
    notifyListeners();
  }

  void pushCountryInfo(BuildContext context, String country) {
    currentCountry = country;
    notifyListeners();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountryInfo(),));
  }

}