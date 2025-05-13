import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wri/common/color.dart';
import 'package:wri/presentation/providers/home_provider.dart';
import 'package:wri/presentation/screens/widget/star_rate.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _TestState();
}

class _TestState extends State<Home> {

  void updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.addListener(updateScreen);
    },);
  }

  @override
  void dispose() {
    homeProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthMedia = MediaQuery.sizeOf(context).width;
    final heightMedia = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/wri_logo.png',
                      height: 40,
                    ),
                    Spacer(),
                    Icon(Icons.notifications_rounded, color: iconColor,),
                    SizedBox(width: widthMedia * 0.05,),
                    Icon(Icons.settings_rounded, color: iconColor,),
                  ],
                ), // 최상단
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    width: widthMedia,
                    height: 54,
                    decoration: BoxDecoration(
                      color: textFiledColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: widthMedia * 0.05,),
                        Expanded(
                          child: TextField(
                            onChanged: (value) async {
                              if (value.isEmpty) {
                                await homeProvider.loadSearchData();
                              }
                            },
                            controller: homeProvider.searchCountryController,
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w400,
                              color: kBlack
                            ),
                            decoration: InputDecoration(
                              hintText: '나라 검색',
                              hintStyle: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                color: searchHintText,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await homeProvider.loadSearchData();
                          },
                          child: Icon(Icons.search_rounded, color: searchIconColor,),
                        ),
                        SizedBox(width: widthMedia * 0.05,),
                      ],
                    ),
                  ),
                ), // 검색창
                homeProvider.searchModel?.state ?? false ?
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '검색결과 ',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w400,
                                    color: kBlack
                                  ),
                                ),
                                TextSpan(
                                  text: homeProvider.searchModel?.state ?? false ?
                                  '${homeProvider.searchModel?.data.length}' : '0',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w700,
                                    color: kBlack
                                  ),
                                ),
                                TextSpan(
                                  text: '개',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w400,
                                    color: kBlack,
                                  ),
                                ),
                              ]
                            )
                          ),
                        ],
                      ),
                    ), // 검색결과
                    SizedBox(
                      width: widthMedia,
                      height: heightMedia * 0.6,
                      child: ListView.builder(
                       itemCount: homeProvider.searchModel?.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  homeProvider.pushCountryInfo(context, homeProvider.searchModel!.data[index].country_code);
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      child: Builder(
                                        builder: (context) {
                                          final flagUrl = homeProvider.searchModel?.data[index].flag_url;
                                          if (flagUrl == null || flagUrl.isEmpty) {
                                            return Container(
                                              width: 60,
                                              height: 90,
                                              color: futureBuilderColor,
                                            );
                                          }
                                          return Image.network(
                                            '${homeProvider.searchModel?.data[index].flag_url}',
                                            height: 60,
                                            width: 90,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Container(
                                                width: 60,
                                                height: 90,
                                                color: futureBuilderColor,
                                              );
                                            },
                                          );
                                        }
                                      ),
                                    ), // 국기
                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${homeProvider.searchModel?.data[index].country_nm}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'inter',
                                              fontWeight: FontWeight.w700,
                                              color: searchDataTextColor
                                            ),
                                          ), // 나라 이름
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${homeProvider.searchModel?.data[index].country_nm}는 ${homeProvider.searchModel?.data[index].continent_nm} 대륙에 위치 해있는 나라 입니다.',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'inter',
                                                fontWeight: FontWeight.w400,
                                                color: moreInfoTextColor
                                            ),
                                          ), // 나라 정보
                                          homeProvider.searchModel!.data[index].alarm_level <= 2 ?
                                          Row(
                                            children: [
                                              Text(
                                                '안전 ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'inter',
                                                  fontWeight: FontWeight.w400,
                                                  color: searchSafeColor
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                'assets/badge_check.svg',
                                                width: 15,
                                                height: 15,
                                                colorFilter: ColorFilter.mode(
                                                  searchSafeColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ],
                                          ) : SizedBox()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,)
                            ],
                          );
                        }
                      ),
                    )
                  ],
                ) : // 검색 결과
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        child: Image.asset(
                          'assets/ad_banner.png',
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ), // 광고 배너
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 70,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/air_plane.png'
                                  ),
                                ),
                                Spacer(flex: 2,),
                                Text(
                                  '항공권',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w400,
                                    color: itemTextColor
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            width: 70,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/exchange_rate.png'
                                  ),
                                ),
                                Spacer(flex: 2,),
                                Text(
                                  '환율',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w400,
                                    color: itemTextColor
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            width: 70,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/roaming.png'
                                  ),
                                ),
                                Spacer(flex: 2,),
                                Text(
                                  '로밍',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w400,
                                    color: itemTextColor
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                            width: 70,
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/event.png'
                                  ),
                                ),
                                Spacer(flex: 2,),
                                Text(
                                  '이벤트',
                                  style: TextStyle(
                                    fontFamily: 'inter',
                                    fontWeight: FontWeight.w400,
                                    color: itemTextColor
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // 아이템
                    SizedBox(height: heightMedia * 0.03,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            '어디로 가볼까?',
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w700,
                              color: kBlack,
                              fontSize: 20
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 95,
                            height: 35,
                            decoration: BoxDecoration(
                              color: textFiledColor,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                              child: Text(
                                '더 보기',
                                style: TextStyle(
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.w400,
                                  color: moreInfoTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), // 어디로 가볼까? - 더보기
                    SizedBox(
                      height: 130,
                      width: widthMedia,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  child: Image.asset(
                                    'assets/travel_suggestion/vietnam.jpg',
                                    height: 70,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                starRate(iconData: Icons.star_half_rounded),
                                Text(
                                  '베트남 / 다낭',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w500,
                                      color: travelSuggestionColor
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    child: Image.asset(
                                      'assets/travel_suggestion/turkey.jpg',
                                      height: 70,
                                      width: 100,
                                    ),
                                  ),
                                  starRate(iconData: Icons.star_border_rounded),
                                  Flexible(
                                    child: Text(
                                      '튀르키예 / 이스탄불',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w500,
                                          color: travelSuggestionColor
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  child: Image.asset(
                                    'assets/travel_suggestion/japan.jpg',
                                    height: 70,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                starRate(iconData: Icons.star_half_rounded),
                                Text(
                                  '일본 / 교토',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w500,
                                      color: travelSuggestionColor
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  child: Image.asset(
                                    'assets/travel_suggestion/italy.jpg',
                                    height: 70,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                starRate(iconData: Icons.star_border_rounded),
                                Text(
                                  '이탈리아 / 로마',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w500,
                                      color: travelSuggestionColor
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  child: Image.asset(
                                    'assets/travel_suggestion/thailand.jpeg',
                                    height: 70,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                starRate(iconData: Icons.star_border_rounded),
                                Text(
                                  '태국 / 치앙마이',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w500,
                                      color: travelSuggestionColor
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), // 어디로 가볼까?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            '추천 여행지',
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w700,
                                color: kBlack,
                                fontSize: 20
                            ),
                          ),
                        ],
                      ),
                    ), // 어디로 가볼까? - 더보기
                    SizedBox(
                      height: 175,
                      width: widthMedia,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    'assets/suggest_image.png',
                                    width: widthMedia,
                                    height: 175,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                'assets/suggest_image_2.jpg',
                                width: widthMedia,
                                height: 175,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                'assets/suggest_image_3.jpg',
                                width: widthMedia,
                                height: 175,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        width: widthMedia,
                        height: 1,
                        color: borderStroke,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            '자세히 알아보기',
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w500,
                              color: countryInfoTextColor,
                              fontSize: 14
                            ),
                          ),
                          Spacer(),
                          Icon(
                            size: 18,
                            Icons.arrow_forward_ios,
                            color: unselectItemColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ), // 어디로 가볼까?
              ],
            ),
          ),
        ),
      ),
    );
  }
}
