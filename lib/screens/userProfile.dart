import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:health_and_doctor_appointment/colors.dart';
import 'package:health_and_doctor_appointment/firestore-data/appointmentHistoryList.dart';
import 'package:health_and_doctor_appointment/screens/userSettings.dart';
import 'package:health_and_doctor_appointment/translations/“locale_keys.g.dart”';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  // Future <Widget> _getImage(BuildContext context, String imageName)async{
  Future _getImage(BuildContext context, String imageName)async{
    // Image image;
String image;
    await FireStorageService.loadImage(context, imageName).then((value){
      // image = Image.network(value.toString());
      image = (value.toString());
     // image = value;
      print("FUTURE IMAGE : $image");
    });
    return image;

   // return value;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {

    return 
      FutureBuilder(
          future: _getImage(context, "${user.uid}"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("IMAGE DATA${snapshot.data}");
              print("IMAGE DATA STRING${snapshot.data.toString()}");
              return Scaffold(
                body: SafeArea(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (
                        OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.1, 0.5],
                                      colors: [
                                        kPrimaryColor,
                                        kPrimaryBrightColor,
                                      ],
                                    ),
                                  ),
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 5,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, right: 7),
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(
                                        FlutterIcons.gear_faw,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserSettings(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 5,
                                  padding: EdgeInsets.only(top: 75),
                                  child: Text(
                                    user.displayName,
                                    style: GoogleFonts.lato(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                snapshot.data == null
                                ? AssetImage('assets/personn.jpeg')
                                : NetworkImage(snapshot.data.toString())
                                //snapshot.data,

                                // image: _imageFile == null
                                //     ? AssetImage('assets/tom.jpg')
                                //     : FileImage(_imageFile),

                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal[50],
                                    width: 5,
                                  ),
                                  shape: BoxShape.circle),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          padding: EdgeInsets.only(left: 20),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 4.25,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[50],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: kPrimaryColor,
                                      child: Icon(
                                        Icons.mail_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.emailPlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 40),
                                    child: Text(
                                      user.email,
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: kPrimaryColor,
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.phonePlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),

                                  // Text(
                                  //   user?.phoneNumber?.isEmpty ?? true
                                  //       ? "Not Added"
                                  //       : user.phoneNumber,
                                  //   style: GoogleFonts.lato(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w600,
                                  //     color: Colors.black54,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: getPhone(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                          padding: EdgeInsets.only(left: 20, top: 20),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 7,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[50],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: kPrimaryColor,
                                      child: Icon(
                                        FlutterIcons.pencil_ent,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.bioPlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: getBio(),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                          padding: EdgeInsets.only(left: 20, top: 20),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 5,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[50],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: Colors.green[900],
                                      child: Icon(
                                        FlutterIcons.history_faw,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.appointmentHistory.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 30,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                              LocaleKeys.viewAllPlaceholder
                                                  .tr()),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Scrollbar(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 35, right: 15),
                                    child: SingleChildScrollView(
                                      child: AppointmentHistoryList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            else return
              Scaffold(
                body: SafeArea(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (
                        OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.1, 0.5],
                                      colors: [
                                        kPrimaryColor,
                                        kPrimaryBrightColor,
                                      ],
                                    ),
                                  ),
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 5,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, right: 7),
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(
                                        FlutterIcons.gear_faw,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserSettings(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 5,
                                  padding: EdgeInsets.only(top: 75),
                                  child: Text(
                                    user.displayName,
                                    style: GoogleFonts.lato(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                AssetImage('assets/personn.jpeg'),

                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.teal[50],
                                    width: 5,
                                  ),
                                  shape: BoxShape.circle),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          padding: EdgeInsets.only(left: 20),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 4.25,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[50],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: kPrimaryColor,
                                      child: Icon(
                                        Icons.mail_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.emailPlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 40),
                                    child: Text(
                                      user.email,
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: kPrimaryColor,
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.phonePlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),

                                  // Text(
                                  //   user?.phoneNumber?.isEmpty ?? true
                                  //       ? "Not Added"
                                  //       : user.phoneNumber,
                                  //   style: GoogleFonts.lato(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w600,
                                  //     color: Colors.black54,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: getPhone(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                          padding: EdgeInsets.only(left: 20, top: 20),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 7,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[50],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: kPrimaryColor,
                                      child: Icon(
                                        FlutterIcons.pencil_ent,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.bioPlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: getBio(),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                          padding: EdgeInsets.only(left: 20, top: 20),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 5,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[50],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 27,
                                      width: 27,
                                      color: Colors.green[900],
                                      child: Icon(
                                        FlutterIcons.history_faw,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleKeys.appointmentHistory.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 30,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                              LocaleKeys.viewAllPlaceholder
                                                  .tr()),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Scrollbar(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 35, right: 15),
                                    child: SingleChildScrollView(
                                      child: AppointmentHistoryList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
      );

    //hereeeee
  }

  Widget getBio() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        var userData = snapshot.data;
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 10, left: 40),
          child: Text(
            (userData['bio'] == null || user.uid == null) ?  LocaleKeys.noBioPlaceholder.tr() : userData['bio'],
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
        );
      },
    );
  }

  Widget getPhone() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        var userData = snapshot.data;
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 10, left: 40),
          child: Text(
            (userData['phone'] == null || user.uid == null) ? "No Phone Number" : userData['phone'],
            // style: GoogleFonts.lato(
            //   fontSize: 16,
            //   fontWeight: FontWeight.w500,
            //   color: Colors.black38,
            // ),
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        );
      },
    );
  }


  }

class FireStorageService extends ChangeNotifier{
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String image) async{
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}

