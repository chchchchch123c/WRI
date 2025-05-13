import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wri/common/string.dart';
import 'package:wri/presentation/providers/country_info_provider.dart';
import 'package:wri/presentation/screens/widget/air_plane_card.dart';
import 'package:wri/presentation/screens/widget/country_intro_template.dart';
import 'package:wri/presentation/screens/widget/expand_text.dart';
import 'package:wri/presentation/screens/widget/tab_bar_delegate.dart';
import 'package:wri/presentation/screens/widget/time_box.dart';

import '../../common/color.dart';

class CountryInfo extends StatefulWidget {
  const CountryInfo({super.key});

  @override
  State<CountryInfo> createState() => _TestState();
}

class _TestState extends State<CountryInfo> with TickerProviderStateMixin {
  late final TabController tabController;

  void updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    countryInfoProvider.loadCountryInfoModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      countryInfoProvider.addListener(updateScreen);
    },);
  }

  @override
  void dispose() {
    countryInfoProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthMedia = MediaQuery.sizeOf(context).width;
    final heightMedia = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: backArrowGray,
            size: 24,
          ),
        ),
        titleSpacing: -15,
        title: Text(
            '${countryInfoProvider.countryInfoModel?.data.country_name}',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ), // 나라 이름
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: heightMedia * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: kBackgroundColor,
                  height: heightMedia * 0.3,
                  width: widthMedia,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: -10,
                        child: Image.asset(
                          'assets/world_image.png',
                          width: widthMedia,
                        ),
                      ), // 세계 지도
                      Positioned(
                        top: 20,
                        child: Builder(
                          builder: (context) {
                            final flagUrl = countryInfoProvider.countryInfoModel?.data.flag_url;
                            if (flagUrl == null || flagUrl.isEmpty) {
                              return Container(
                                width: 180,
                                height: 120,
                                color: futureBuilderColor,
                              );
                            }
                            return Image.network(
                              '${countryInfoProvider.countryInfoModel?.data.flag_url}',
                              width: 180,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 180,
                                  height: 120,
                                  color: futureBuilderColor,
                                );
                              },
                            );
                          }
                        ),
                      ), // 국기
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: widthMedia,
                          height: heightMedia * 0.18,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                kTransparentColor,
                                kBackgroundColor,
                                kBackgroundColor,
                              ],
                            ),
                          ),
                        ),
                      ), // 리니얼 그라디언트
                    ],
                  ),
                ),
              ),
            ), // 국기 이미지
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(
                widget: Container(
                  color: kBackgroundColor,
                  child: TabBar(
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    controller: tabController,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: tabBarIndicatorColor,
                    indicatorColor: kBlack,
                    onTap: (value) {
                      setState(() {});
                    },
                    labelColor: kBlack,
                    unselectedLabelColor: tabBarColor,
                    labelStyle: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.visible,
                    ),
                    tabs: [
                      Tab(text: '소개', ),
                      Tab(text: '정보', ),
                      Tab(text: '환율', ),
                      Tab(text: '여행지', ),
                      Tab(text: '항공편', ),
                    ],
                  ),
                )
              ),
            ), // 탭바
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: heightMedia * 2,
                      width: widthMedia,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${countryInfoProvider.countryInfoModel?.data.country_name} (${countryInfoProvider.countryInfoModel?.data.continent})',
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30
                                        ),
                                      ),
                                    ),
                                  ],
                                ), // 나라 이름
                                expandText(
                                  text: countryInfoProvider.countryInfoModel?.data.extract ?? '',
                                ), // 나라 상세 설명
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        '여행 경보',
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                        ),
                                      ),
                                      SizedBox(width: 2.5,),
                                      Icon(
                                        Icons.warning_rounded,
                                        size: 16,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(context: context, builder: (context) {
                                            return Dialog(
                                              insetPadding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Builder(
                                                  builder: (context) {
                                                    final flagUrl = countryInfoProvider.countryInfoModel?.data.dang_map_download_url;
                                                    if (flagUrl == null || flagUrl.isEmpty) {
                                                      return Container(
                                                        width: widthMedia,
                                                        height: 344.0,
                                                        decoration: BoxDecoration(
                                                          color: futureBuilderColor,
                                                          borderRadius: BorderRadius.all(Radius.circular(24)),
                                                        ),
                                                      );
                                                    }
                                                    return Container(
                                                      width: widthMedia,
                                                      height: widthMedia,
                                                      decoration: BoxDecoration(
                                                        color: dialogBackgroundColor,
                                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                                            child: Image.network(
                                                              '$url${countryInfoProvider.countryInfoModel?.data.dang_map_download_url}',
                                                              width: widthMedia,
                                                              loadingBuilder: (context, child, loadingProgress) {
                                                                if (loadingProgress == null) return child;
                                                                return Container(
                                                                  width: widthMedia,
                                                                  height: 344.0,
                                                                  decoration: BoxDecoration(
                                                                    color: dialogBackgroundColor,
                                                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Container(
                                                                width: widthMedia,
                                                                decoration: BoxDecoration(
                                                                  color: dialogBackgroundColor,
                                                                  borderRadius: BorderRadius.all(Radius.circular(24))
                                                                ),
                                                                child: Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                    child: Container(
                                                                      width: widthMedia,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                        color: kBackgroundColor,
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          '닫기',
                                                                          style: TextStyle(
                                                                            fontFamily: 'inter',
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 12
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }
                                              ),
                                            );
                                          },);
                                        },
                                        child: Container(
                                          width: 95,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: textFiledColor,
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '지도보기',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'inter',
                                                fontWeight: FontWeight.w500,
                                                color: openMapColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ), // 지도 보기
                                    ],
                                  ),
                                ), // 여행경보
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: countryInfoProvider.levelColorList[
                                          countryInfoProvider.getLevelColorIndex(
                                              countryInfoProvider.countryInfoModel?.data.alarm_level ?? 0)],
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            color: kBackgroundColor,
                                            shape: BoxShape.circle
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${countryInfoProvider.countryInfoModel?.data.alarm_level}',
                                              style: TextStyle(
                                                fontFamily: 'inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                                color: countryInfoProvider.levelColorList[
                                                countryInfoProvider.getLevelColorIndex(
                                                    countryInfoProvider.countryInfoModel?.data.alarm_level ?? 0)]
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), // 래밸 서클
                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            countryInfoProvider.levelTextList[
                                            countryInfoProvider.getLevelColorIndex(
                                                countryInfoProvider.countryInfoModel?.data.alarm_level ?? 0)],
                                            style: TextStyle(
                                              fontFamily: 'inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16
                                            ),
                                          ),
                                          Text(
                                            '외교부 제공',
                                            style: TextStyle(
                                              fontFamily: 'inter',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: mfaProviderColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ), // 래밸
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                countryIntroTemplate(introName: '시간대', icon: Icons.access_time_filled_rounded, countryInfo: (countryInfoProvider.countryInfoModel?.data.info.time ??
                                    'UTC +0')),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '한국 시각',
                                            style: TextStyle(
                                              fontFamily: 'inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5),
                                            child: Row(
                                              children: [
                                                timeBox(nowTime: countryInfoProvider.nowH1),
                                                timeBox(nowTime: countryInfoProvider.nowH2),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 1.5),
                                                  child: Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontFamily: 'inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                timeBox(nowTime: countryInfoProvider.nowM1),
                                                timeBox(nowTime: countryInfoProvider.nowM2),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ), // 한국 시간
                                      SizedBox(width: widthMedia * 0.1,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '현지 시각',
                                            style: TextStyle(
                                              fontFamily: 'inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5),
                                            child: Row(
                                              children: [
                                                timeBox(nowTime: countryInfoProvider.utcH1),
                                                timeBox(nowTime: countryInfoProvider.utcH2),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 1.5),
                                                  child: Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontFamily: 'inter',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                timeBox(nowTime: countryInfoProvider.utcM1),
                                                timeBox(nowTime: countryInfoProvider.utcM2),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ), // 현지 시간
                                    ],
                                  ),
                                ), // 한국 시간, 현지 시간
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '언어',
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16
                                        ),
                                      ),
                                      SizedBox(width: 2.5,),
                                      SvgPicture.asset(
                                        'assets/language.svg',
                                        width: 16,
                                        height: 16,
                                        colorFilter: ColorFilter.mode(kBlack, BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                ), // 언어
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        (countryInfoProvider.countryInfoModel?.data.info.language ??
                                            '영어(공용어)'),
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ],
                                ), // 영어(공용어)
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/info.svg',
                                      width: 13,
                                      height: 13,
                                      colorFilter: ColorFilter.mode(languageColor, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      '파파고 또는 구글 번역기를 사용하여 소통이 가능해요.',
                                      style: TextStyle(
                                        color: languageColor,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ), // 번역기
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                countryIntroTemplate(introName: '기후', icon: Icons.thunderstorm_rounded, countryInfo: (countryInfoProvider.countryInfoModel?.data.info.climate ??
                                    '대체로 더운 기후를 가지고 있어요.')),
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '화폐 정보',
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16
                                        ),
                                      ),
                                      SizedBox(width: 2.5,),
                                      Icon(
                                        Icons.attach_money_rounded,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ), // 화폐
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        (countryInfoProvider.countryInfoModel?.data.info.currency ??
                                            '달러를 사용해요.'),
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: climateColor
                                        ),
                                      ),
                                    ),
                                  ],
                                ), // 화폐 설명
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/info.svg',
                                      width: 11,
                                      height: 11,
                                      colorFilter: ColorFilter.mode(languageColor, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      '데이터는 정확하지 않을 수 있어요.',
                                      style: TextStyle(
                                        color: languageColor,
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ), // 데이터는..
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                countryIntroTemplate(
                                    introName: '종교',
                                    icon: Icons.church_rounded,
                                    countryInfo: (countryInfoProvider.countryInfoModel?.data.info.religion ??
                                    '대체로 개신교가 대부분을 차지 하고 있어요.')),
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                countryIntroTemplate(
                                    introName: '위치',
                                    icon: Icons.pin_drop_rounded,
                                    countryInfo: (countryInfoProvider.countryInfoModel?.data.info.location??
                                    '유럽에 자리 잡고 있어요.')), // 위치
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                countryIntroTemplate(
                                    introName: '인구수',
                                    icon: Icons.family_restroom_rounded,
                                    countryInfo: (countryInfoProvider.countryInfoModel?.data.info.population??
                                    '대한민국의 1.2 배의 국민이 살아가고 있어요.')), // 인국수
                                SizedBox(
                                  height: heightMedia * 0.05,
                                ),
                                countryIntroTemplate(introName: '국가 면적',
                                    icon: Icons.map_rounded,
                                    countryInfo: (countryInfoProvider.countryInfoModel?.data.info.area ??
                                    '대한민국의 1.7 배의 면적을 가지고 있어요.')), // 국가 면적
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '수도',
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ), // 수도
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child: Image.asset(
                                      countryInfoProvider.capitalCityImage,
                                      width: widthMedia,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${countryInfoProvider.countryInfoModel?.data.info.capitalCity}',
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: climateColor
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${countryInfoProvider.countryInfoModel?.data.country_name}의 인프라',
                                          style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ), // 수도
                                Text(
                                  countryInfoProvider.countryInfoModel?.data.extract ?? '',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w400,
                                    color: countryInfoTextColor,
                                    fontSize: 12
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '원(KRW) ⇔ 달러(USD)',
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ), // 환율
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        '1. 기준금리',
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child: Image.asset(
                                      'assets/exchange_rate/graph1.png',
                                      width: widthMedia,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  exchangeRateText1,
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: climateColor
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                                  child: Container(height: 1, width: widthMedia, color: searchIconColor,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        '2. 물가',
                                        style: TextStyle(
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child: Image.asset(
                                      'assets/exchange_rate/graph2.png',
                                      width: widthMedia,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  exchangeRateText2,
                                  style: TextStyle(
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: climateColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Image.asset('assets/empty_image.png'),
                                SizedBox(height: 15,),
                                Text(
                                  '이 페이지는 준비 중이에요.',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '다른 페이지로 여행을 떠나보는 건 어떨까요?',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: searchIconColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                airPlaneCard(imageUrl: 'KoreanAir_logo.png', name: '대한 항공'),
                                airPlaneCard(imageUrl: 'Asiana_Airlines.png', name: '아시아나 항공'),
                                airPlaneCard(imageUrl: 'Jeju_Air.png', name: '제주 항공'),
                                airPlaneCard(imageUrl: 'Jin_Air.png', name: '진에어'),
                                airPlaneCard(imageUrl: 'Tway_Air_logo.png', name: '티웨이'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
