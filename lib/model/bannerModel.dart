import 'package:flutter/material.dart';
import 'package:health_and_doctor_appointment/translations/“locale_keys.g.dart”';
import 'package:easy_localization/easy_localization.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModel(this.text, this.cardBackground, this.image);
}

List<BannerModel> bannerCards = [
  new BannerModel(
      LocaleKeys.bannerModel1.tr(),
      [
        Color(0xffa1d4ed),
        Color(0xffc0eaff),
      ],
      "assets/414-bg.png"),
  new BannerModel(
      LocaleKeys.bannerModel2.tr(),
      [
        Color(0xffb6d4fa),
        Color(0xffcfe3fc),
      ],
      "assets/covid-bg.png"),
];
