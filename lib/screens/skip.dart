//import 'dart:html';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../colors.dart';
import 'firebaseAuth.dart';
import 'package:health_and_doctor_appointment/translations/“locale_keys.g.dart”';

class Skip extends StatefulWidget {
  @override
  _SkipState createState() => _SkipState();
}

class _SkipState extends State<Skip> {

  //var title = tr('title')

  List<PageViewModel> getpages() {
    return [
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/language.png',
          //fit: BoxFit.cover,
        ),
        //body: "Search Doctors",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
             // "Lang",
              //"skipPage1Title".tr().toString(),
              LocaleKeys.skipPage1Title.tr(),
              style:
              GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: 200.0,
              child: ElevatedButton(

                  onPressed:(){
                context.deviceLocale.toString();
                setState(()async{
                  await context.setLocale(Locale('en'));

                });
              }, child: Text("English")),
            ),
            SizedBox(height: 10,),
SizedBox(
  width: 200.0,
  child:   ElevatedButton(onPressed:(){
    context.deviceLocale.toString();
    setState(()async{
  await context.setLocale(Locale('fr'));
    });
  }, child: Text("Français")),
),

            // Text(
            //   'English or French',
            //   style: GoogleFonts.lato(
            //       fontSize: 15,
            //       color: Colors.grey[500],
            //       fontWeight: FontWeight.w800),
            // ),
          ],
        ),
      ),
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/doc.png',
          //fit: BoxFit.cover,
        ),
        //body: "Search Doctors",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '1.',
              style:
              GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            Text(
              LocaleKeys.skipPage2Title.tr(),
              style:
                  GoogleFonts.lato(fontSize: 26, fontWeight: FontWeight.w900),
            ),
            Text(
              //'Find a time that works for your schedule',
              LocaleKeys.skipPage2SubTitle.tr(),
              style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      PageViewModel(
        title: '',
        image: Image.asset(
          'assets/light.png',
          //fit: BoxFit.cover,
        ),
        //body: "Search Doctors",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '2.',
              style:
              GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.w900),
            ),
             Text(
               // 'Keep Track of Appointments',
               LocaleKeys.skipPage3Title.tr(),
                style:
                    GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            Text(
              //'Keep up to date on upcoming consultations',
              LocaleKeys.skipPage3SubTitle.tr(),
              style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.lightBlue[100],
        pages: getpages(),
        showNextButton: false,
        showSkipButton: true,
        skip: SizedBox(
          width: 80,
          height: 48,
          child: Card(
            child: Center(
              child: Text(
                LocaleKeys.skipPlaceholder.tr(),
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.blue[300],
            shadowColor: Colors.blueGrey[100],
            elevation: 5,
          ),
        ),
        done: SizedBox(
          height: 48,
          child: Card(
            child: Center(
              child:
              Text(
                LocaleKeys.continuePlaceholder.tr(),
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w900),
              ),

              // Text((()
              // {
              //   var lang = EasyLocalization.of(context).currentLocale;
              //   if (lang == "fr") {
              //     print("FR $lang");
              //     return LocaleKeys.continuePlaceholder.tr();
              //   }
              //   else  if (lang == "en") {
              //     print("EN $lang");
              //     return LocaleKeys.continuePlaceholder.tr();
              //   }
              //   else{
              //     print("NA $lang");
              //     LocaleKeys.continuePlaceholder.tr();
              //   }
              // })(),
              //   style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w900),),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // color: Colors.blue[300],
            color: kPrimaryDarkerBlueColor,
            shadowColor: Colors.blueGrey[200],
            elevation: 5,
          ),
        ),
        onDone: () => _pushPage(context, FireBaseAuth()),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
