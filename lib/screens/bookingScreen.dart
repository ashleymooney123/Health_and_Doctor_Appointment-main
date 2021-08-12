import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/colors.dart';
import 'package:health_and_doctor_appointment/screens/myAppointments.dart';
import 'package:intl/intl.dart';
import 'package:health_and_doctor_appointment/translations/“locale_keys.g.dart”';
import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
 import 'dart:io';
// import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../colors.dart';
//import 'package:video_player/video_player.dart';
//import "dart:html";

class BookingScreen extends StatefulWidget {
//  final String doctor;

 // const BookingScreen({Key key, this.doctor}) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  File _image;
  String _phone;
  final imagePicker = ImagePicker();

  //get _realValue => null;

  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);

      // String fileName = File(image.path).toString();
      // StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      // StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      // taskSnapshot.ref.getDownloadURL().then(
      //       (value) => print("Done: $value"),
      // );

      // uploadPic(_image);

      // FirebaseStorage storage = FirebaseStorage.instance;
      // String url;
      // Reference ref = storage.ref().child("image" + DateTime.now().toString());
      // UploadTask uploadTask = ref.putFile(_image);
      // uploadTask.whenComplete(() {
      //   url = ref.getDownloadURL() as String;
      // }).catchError((onError) {
      //   print(onError);
      // });
      // return url;

      // Navigator.pop(context);
    });
  }

  String userID;
  String nameFirebase;
  int dropdownValue = 5;
  String dateDropdownValue = "Monday @ 4:30 PM";
  String dateDropdownFinal = "";
  DateTime initialDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select Time';
  String dateUTC;
  String dateTime;

  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
    userID = user.uid;
    nameFirebase = user.displayName;
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),

        selectableDayPredicate: (DateTime val) =>
      val.weekday == 6 || val.weekday == 7 || val.weekday == 2 ? false : true,


    ).then(
          (date) {
        setState(
              () {
            selectedDate = date;
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectDateMonday(BuildContext context) async {
    if(DateTime.now().weekday == 1){
      initialDate = DateTime.now();
    }else if(DateTime.now().weekday == 2){
      initialDate = DateTime.now().add(Duration(hours: 144));
    }else if(DateTime.now().weekday == 3){
      initialDate = DateTime.now().add(Duration(hours: 120));
    }else if(DateTime.now().weekday == 4){
      initialDate = DateTime.now().add(Duration(hours: 96));
    }else if(DateTime.now().weekday == 5){
      initialDate = DateTime.now().add(Duration(hours: 72));
    }else if(DateTime.now().weekday == 6){
      initialDate = DateTime.now().add(Duration(hours: 48));
    }else if(DateTime.now().weekday == 7){
      initialDate = DateTime.now().add(Duration(hours: 24));
    }else{
      print("WEEKDAY VALUE : ${DateTime.now().weekday}");
      initialDate = DateTime.now();
    }
    debugPrint("DATE NOW: ${DateTime.now()}");
    showDatePicker(

      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2025),

      selectableDayPredicate: (DateTime val) =>
      val.weekday == 2 || val.weekday == 3 || val.weekday == 4 || val.weekday == 5 || val.weekday == 6 || val.weekday == 7 ? false : true,


    ).then(
          (date) {
        setState(
              () {
            selectedDate = date;
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectDateWednesday(BuildContext context) async {
    if(DateTime.now().weekday == 3){
      initialDate = DateTime.now();
    }else if(DateTime.now().weekday == 4){
      initialDate = DateTime.now().add(Duration(hours: 144));
    }else if(DateTime.now().weekday == 5){
      initialDate = DateTime.now().add(Duration(hours: 120));
    }else if(DateTime.now().weekday == 6){
      initialDate = DateTime.now().add(Duration(hours: 96));
    }else if(DateTime.now().weekday == 7){
      initialDate = DateTime.now().add(Duration(hours: 72));
    }else if(DateTime.now().weekday == 1){
      initialDate = DateTime.now().add(Duration(hours: 48));
    }else if(DateTime.now().weekday == 2){
      initialDate = DateTime.now().add(Duration(hours: 24));
    }else{
      print("WEEKDAY VALUE : ${DateTime.now().weekday}");
      initialDate = DateTime.now();
    }
    debugPrint("DATE NOW: ${DateTime.now()}");
    showDatePicker(

      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2025),

      selectableDayPredicate: (DateTime val) =>
      val.weekday == 2 || val.weekday == 1 || val.weekday == 4 || val.weekday == 5 || val.weekday == 6 || val.weekday == 7 ? false : true,


    ).then(
          (date) {
        setState(
              () {
            selectedDate = date;
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }
  Future<void> selectDateThursday(BuildContext context) async {
    if(DateTime.now().weekday == 4){
      initialDate = DateTime.now();
    }else if(DateTime.now().weekday == 5){
      initialDate = DateTime.now().add(Duration(hours: 144));
    }else if(DateTime.now().weekday == 6){
      initialDate = DateTime.now().add(Duration(hours: 120));
    }else if(DateTime.now().weekday == 7){
      initialDate = DateTime.now().add(Duration(hours: 96));
    }else if(DateTime.now().weekday == 1){
      initialDate = DateTime.now().add(Duration(hours: 72));
    }else if(DateTime.now().weekday == 2){
      initialDate = DateTime.now().add(Duration(hours: 48));
    }else if(DateTime.now().weekday == 3){
      initialDate = DateTime.now().add(Duration(hours: 24));
    }else{
      print("WEEKDAY VALUE : ${DateTime.now().weekday}");
      initialDate = DateTime.now();
    }
    debugPrint("DATE NOW: ${DateTime.now()}");
    showDatePicker(

      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2025),

      selectableDayPredicate: (DateTime val) =>
      val.weekday == 2 || val.weekday == 1 || val.weekday == 3 || val.weekday == 5 || val.weekday == 6 || val.weekday == 7 ? false : true,


    ).then(
          (date) {
        setState(
              () {
            selectedDate = date;
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectDateFriday(BuildContext context) async {
    if(DateTime.now().weekday == 5){
      initialDate = DateTime.now();
    }else if(DateTime.now().weekday == 6){
      initialDate = DateTime.now().add(Duration(hours: 144));
    }else if(DateTime.now().weekday == 7){
      initialDate = DateTime.now().add(Duration(hours: 120));
    }else if(DateTime.now().weekday == 1){
      initialDate = DateTime.now().add(Duration(hours: 96));
    }else if(DateTime.now().weekday == 2){
      initialDate = DateTime.now().add(Duration(hours: 72));
    }else if(DateTime.now().weekday == 3){
      initialDate = DateTime.now().add(Duration(hours: 48));
    }else if(DateTime.now().weekday == 4){
      initialDate = DateTime.now().add(Duration(hours: 24));
    }else{
      print("WEEKDAY VALUE : ${DateTime.now().weekday}");
      initialDate = DateTime.now();
    }
    debugPrint("DATE NOW: ${DateTime.now()}");
    showDatePicker(

      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2025),

      selectableDayPredicate: (DateTime val) =>
      val.weekday == 2 || val.weekday == 1 || val.weekday == 3 || val.weekday == 4 || val.weekday == 6 || val.weekday == 7 ? false : true,


    ).then(
          (date) {
        setState(
              () {
            selectedDate = date;
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime,
        alwaysUse24HourFormat: false);

    if (formattedTime != null) {
      setState(() {
        timeText = formattedTime;
        _timeController.text = timeText;
        print("TIME STRING : $timeText");
      });
    }
    dateTime = selectedTime.toString().substring(10, 15);
    debugPrint("DATE TIME STRING : $dateTime");
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyAppointments(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        LocaleKeys.donePlaceholder.tr(),
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        LocaleKeys.registeredPlaceholder.tr(),
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _getUser();
    selectTime(context);
    //_getPhone();
    FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((snapshot) => setUserDetails(snapshot.data()));
    //  _doctorController.text = widget.doctor;
  }

  @override
  Widget build(BuildContext context) {
    //var value;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data;
            if (userData['phone'] != null) {

              return Scaffold(
                backgroundColor: Colors.white,
                key: _scaffoldKey,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    LocaleKeys.bookingPlaceholder.tr(),
                    style: GoogleFonts.lato(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                body: SafeArea(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (
                        OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          child: Image(
                            image: AssetImage('assets/appointment.jpg'),
                            height: 250,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.only(top: 0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    LocaleKeys.patientDetailsPlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: _nameController,
                                  focusNode: f1,
                                  validator: (value) {
                                    if (value.isEmpty && (user.displayName == null))
                                      return LocaleKeys
                                        .patientNamePlaceholder.tr();
                                    return null;
                                  },
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.only(
                                        left: 20, top: 10, bottom: 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[350],
                                    // hintText: LocaleKeys.patientNameStarPlaceholder.tr(),
                                    hintText: user.displayName == null
                                        ? LocaleKeys
                                        .patientNameStarPlaceholder.tr()
                                        : user
                                        .displayName,
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  onFieldSubmitted: (String value) {
                                    f1.unfocus();
                                    FocusScope.of(context).requestFocus(f2);
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  focusNode: f2,
                                  controller: _phoneController,
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.only(
                                        left: 20, top: 10, bottom: 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[350],
                                    hintText:
                                    userData['phone'],
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty && (userData['phone'] == null)) {
                                      return LocaleKeys.phoneEnterText.tr();
                                    } else if (value.length < 10 && (userData['phone'] == null)) {
                                      return LocaleKeys.phoneErrorText.tr();
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String value) {
                                    f2.unfocus();
                                    FocusScope.of(context).requestFocus(f3);
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  focusNode: f3,
                                  controller: _descriptionController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.only(
                                        left: 20, top: 10, bottom: 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[350],
                                    hintText: LocaleKeys.descriptionPlaceholder
                                        .tr(),
                                    hintStyle: GoogleFonts.lato(
                                      color: Colors.black26,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return LocaleKeys
                                          .medicalWarningPlaceholder
                                          .tr();
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String value) {
                                    f3.unfocus();
                                    FocusScope.of(context).requestFocus(f4);
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                /////////////////////////////////////////////////////////////////
//     Container(
//       margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
//       padding: EdgeInsets.symmetric(horizontal: 0),
//       height: MediaQuery.of(context).size.height / 16,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(40),
//         color: Colors.grey[350],
//       ),
//         child: Stack(
//
//             alignment: Alignment.centerLeft,
//             children: [
//               // InputDecoration(
//               //   isDense: true,
//               // ),
//                DropdownButtonFormField<int>(
//                  isDense: true,
//
//         //   decoration: InputDecoration.collapsed(hintText: ''),
//                  decoration: InputDecoration( border: InputBorder.none , contentPadding: EdgeInsets.zero),
// isExpanded: true,
// itemHeight: 50,
// //itemHeight: MediaQuery.of(context).size.height / 16 ,
//           //DropdownButton<int>(
//
//           //   validator: (value) {
//           //     if (value == null) {
//           //       print("VALUEEE $value");
//           //       return LocaleKeys
//           //           .medicalWarningPlaceholder
//           //           .tr();
//           //     }
//           //     return null;
//           //   },
// hint: Padding(
//   padding: const EdgeInsets.only(left: 10),
//   child:   Text(LocaleKeys.numberOfPlantsPlaceholder.tr(), style: GoogleFonts.lato(
//     color: Colors.black26,
//     fontSize: 18,
//     fontWeight: FontWeight.w800,
//   ),),
// ),
//
//      // value: dropdownValue,
//       icon:
//
//                          // Container(
//                          //   height: MediaQuery.of(context).size.height / 16,
//                          // // width: MediaQuery.of(context).size.width,
//                          //   child:
//                          //   Stack(
//                          //      alignment: Alignment.centerRight,
//                          //     children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                   right: 5.0),
//               child:
//                                ClipOval(
//                         child:
//                         Material(
//                                     color: kPrimaryBrightColor,
//                                     child: InkWell(
//                                     // child: Container(
//                                     //   width: 80,
//                                     //   height: 80,
//                                       child: Expanded(
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                                         width: 40,
//                                                         height: 40,
//                                               child:  Icon( Icons.arrow_downward,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                        // ),
//       ),
//             ),
//         ),
//                          //     ],
//                          //   ),
//                          // ),
//
//           iconSize: 24,
//           elevation: 16,
//           style: GoogleFonts.lato(
//               fontSize: 18,
//               fontWeight: FontWeight.bold, color: Colors.black),
//           // underline: Container(
//           // height: 2,
//           // color: Colors.transparent,
//           // ),
//           onChanged: (int newValue) {
//
//           setState(() {
//           dropdownValue = newValue;
//           });
//           },
//           items: <int>[
//             25,
//             49,
//             73,
//             98,
//             146,
//             171,
//             195,
//             244,
//             268,
//             317,
//             365,
//             390,
//             438,
//             482]
//               .map<DropdownMenuItem<int>>((int value) {
//           return DropdownMenuItem<int>(
//
//           value: value,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15.0),
//             child: Text("$value"),
//           ),
//           );
//           }).toList(),
//                  validator: (value) {
//                    if (value == null) {
//                      print("VALUEEE $value");
//                      return LocaleKeys
//                          .numberOfPlantsWarningPlaceholder
//                          .tr();
//                    }
//                    return null;
//                  },
//           ),
//             ]),
//     ),
                                /////////////////////////////////////////////////////////////////
                                //plants text field
                                // TextFormField(
                                //   controller: _doctorController,
                                //   validator: (value) {
                                //     if (value.isEmpty)
                                //       return 'Please enter Number of Plants';
                                //     return null;
                                //   },
                                //   style: GoogleFonts.lato(
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.bold),
                                //   decoration: InputDecoration(
                                //     contentPadding:
                                //     EdgeInsets.only(
                                //         left: 20, top: 10, bottom: 10),
                                //     border: OutlineInputBorder(
                                //       borderRadius:
                                //       BorderRadius.all(Radius.circular(90.0)),
                                //       borderSide: BorderSide.none,
                                //     ),
                                //     filled: true,
                                //     fillColor: Colors.grey[350],
                                //     hintText: LocaleKeys
                                //         .numberOfPlantsPlaceholder
                                //         .tr(),
                                //     hintStyle: GoogleFonts.lato(
                                //       color: Colors.black26,
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.w800,
                                //     ),
                                //   ),
                                // ),

                                //SizedBox(
                                //   height: 20,
                                // ),

                                //photo field

                                //////TEST!

                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      DropdownButtonFormField(

                                        isExpanded: true,
                                        isDense: true,
                                        iconEnabledColor: kPrimaryBrightColor,
                                        icon:

                                        Padding(
                                  padding: const EdgeInsets.only(
                                         right: 5.0),
                                          child: ClipOval(

                                             child:
                                            Material(
                                              color: Colors.transparent,
                                              child:
                                              InkWell(
                                                child: SizedBox(
                                                            width: 40,
                                                            height: 40,
                                                  child: Icon(
                                                        Icons.arrow_downward,
                                                        color: kPrimaryBrightColor,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        focusNode: f5,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                           // top: 10,
                                          //  bottom: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[350],
                                          hintText: LocaleKeys
                                              .numberOfPlantsPlaceholder.tr(),
                                          hintStyle: GoogleFonts.lato(
                                            color: Colors.black26,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        //controller: _dateController,
                                        // validator: (value) {
                                        //   if (value.isEmpty)
                                        //     return LocaleKeys
                                        //         .dateWarningPlaceholder.tr();
                                        //   return null;
                                        // },
                                        onChanged: (int newValue) {

                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <int>[
                                          25,
                                          49,
                                          73,
                                          98,
                                          146,
                                          171,
                                          195,
                                          244,
                                          268,
                                          317,
                                          365,
                                          390,
                                          438,
                                          482]
                                            .map<DropdownMenuItem<int>>((int value) {
                                          return DropdownMenuItem<int>(

                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 0.0),
                                              child: Text("$value" , style: TextStyle(color: Colors.black),),
                                            ),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            print("VALUEEE $value");
                                            return LocaleKeys
                                                .numberOfPlantsWarningPlaceholder
                                                .tr();
                                          }
                                          return null;
                                        },
                                        // onFieldSubmitted: (String value) {
                                        //   f5.unfocus();
                                        //   FocusScope.of(context).requestFocus(
                                        //       f6);
                                        // },
                                        //textInputAction: TextInputAction.next,
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextFormField(
                                        focusNode: f4,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[350],
                                          hintText: _image == null
                                              ? LocaleKeys
                                              .selectPhotoPlaceholder.tr()
                                              : _image
                                              .toString(),
                                          //hintText: LocaleKeys.selectPhotoPlaceholder.tr(),
                                          hintStyle:
                                          _image == null ?
                                          GoogleFonts.lato(
                                            color: Colors.black26,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ) :
                                          GoogleFonts.lato(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),

                                        ),
                                        //controller: _dateController,
                                        validator: (value) {
                                          if (_image == null)
                                            return LocaleKeys
                                                .photoIDWarningPlaceholder
                                                .tr();
                                          return null;
                                        },
                                        onFieldSubmitted: (String value) {
                                          f4.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              f5);
                                        },
                                        textInputAction: TextInputAction.next,
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            // button color
                                            child: InkWell(
                                              // inkwell color
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: kPrimaryBrightColor,
                                                ),
                                              ),
                                              // onTap: () {
                                              // //  selectDate(context);
                                              //
                                              //  // _onImageButtonPressed(ImageSource.gallery, context: context);
                                              //   getImage();
                                              //
                                              // },
                                              onTap: getImage,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height:10),
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      DropdownButtonFormField(

                                        isExpanded: true,
                                        isDense: true,
                                        iconEnabledColor: kPrimaryBrightColor,
                                        icon:

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0),
                                          child: ClipOval(

                                            child:
                                            Material(
                                              color: Colors.transparent,
                                              child:
                                              InkWell(
                                                child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: Icon(
                                                    Icons.timer,
                                                    color: kPrimaryBrightColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        focusNode: f5,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            // top: 10,
                                            //  bottom: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[350],
                                          hintText: LocaleKeys
                                              .selectDatePlaceholder.tr(),
                                          hintStyle: GoogleFonts.lato(
                                            color: Colors.black26,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        //controller: _dateController,
                                        // validator: (value) {
                                        //   if (value.isEmpty)
                                        //     return LocaleKeys
                                        //         .dateWarningPlaceholder.tr();
                                        //   return null;
                                        // },
                                        onChanged: (String dateValue) {

                                          setState(() {
                                            dateDropdownValue = dateValue;
                                            debugPrint("DATE VALUE: $dateValue");
                                            debugPrint("DROP DOWN DATE VALUE: $dateDropdownValue");
                                            debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");

                                            //PIE
                                            if(dateValue == "Monday @ 4:30 PM"){
                                              dateDropdownFinal = "16:30";
                                              debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                            }else if(dateValue == "Wednesday @ 1:45 PM"){
                                              dateDropdownFinal = "13:45";
                                              debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                            }else if(dateValue == "Thursday @ 7:00 PM"){
                                              dateDropdownFinal = "19:00";
                                              debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                            }else if(dateValue == "Friday @ 4:30 PM"){
                                              dateDropdownFinal = "16:30";
                                              debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                            }
                                            else {
                                             // dateDropdownValue = dateValue;
                                            }
                                          });
                                        },
                                        items: <String>[
                                          "Monday @ 4:30 PM",
                                          "Wednesday @ 1:45 PM",
                                          "Thursday @ 7:00 PM",
                                          "Friday @ 4:30 PM"
                                        ]
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(

                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 0.0),
                                              child: Text("$value" , style: TextStyle(color: Colors.black),),
                                            ),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            print("VALUEEE $value");
                                            return LocaleKeys
                                                .timeWarningPlaceholder
                                                .tr();
                                          }
                                          return null;
                                        },
                                        // onFieldSubmitted: (String value) {
                                        //   f5.unfocus();
                                        //   FocusScope.of(context).requestFocus(
                                        //       f6);
                                        // },
                                        //textInputAction: TextInputAction.next,
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //OLD CALENDAR PICKER

                                // Container(
                                //   alignment: Alignment.center,
                                //   height: 60,
                                //   width: MediaQuery
                                //       .of(context)
                                //       .size
                                //       .width,
                                //   child: Stack(
                                //     alignment: Alignment.centerRight,
                                //     children: [
                                //       TextFormField(
                                //         focusNode: f5,
                                //         decoration: InputDecoration(
                                //           contentPadding: EdgeInsets.only(
                                //             left: 20,
                                //             top: 10,
                                //             bottom: 10,
                                //           ),
                                //           border: OutlineInputBorder(
                                //             borderRadius:
                                //             BorderRadius.all(
                                //                 Radius.circular(90.0)),
                                //             borderSide: BorderSide.none,
                                //           ),
                                //           filled: true,
                                //           fillColor: Colors.grey[350],
                                //           hintText: LocaleKeys
                                //               .selectDatePlaceholder.tr(),
                                //           hintStyle: GoogleFonts.lato(
                                //             color: Colors.black26,
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w800,
                                //           ),
                                //         ),
                                //         controller: _dateController,
                                //         validator: (value) {
                                //           if (value.isEmpty)
                                //             return LocaleKeys
                                //                 .dateWarningPlaceholder.tr();
                                //           return null;
                                //         },
                                //         onFieldSubmitted: (String value) {
                                //           f5.unfocus();
                                //           FocusScope.of(context).requestFocus(
                                //               f6);
                                //         },
                                //         textInputAction: TextInputAction.next,
                                //         style: GoogleFonts.lato(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //       Padding(
                                //         padding: const EdgeInsets.only(
                                //             right: 5.0),
                                //         child: ClipOval(
                                //            child:
                                //           Material(
                                //             color: Colors.transparent,
                                //             // button color
                                //             child: InkWell(
                                //               // inkwell color
                                //               child: SizedBox(
                                //                 width: 40,
                                //                 height: 40,
                                //                 child: Icon(
                                //                   Icons.date_range_outlined,
                                //                   color: kPrimaryBrightColor,
                                //                 ),
                                //               ),
                                //               onTap: () {
                                //                 selectDate(context);
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
//SIMONS DATES
                                // Container(
                                //   alignment: Alignment.center,
                                //   height: 60,
                                //   width: MediaQuery
                                //       .of(context)
                                //       .size
                                //       .width,
                                //   child: Stack(
                                //     alignment: Alignment.centerRight,
                                //     children: [
                                //       TextFormField(
                                //         focusNode: f5,
                                //         decoration: InputDecoration(
                                //           contentPadding: EdgeInsets.only(
                                //             left: 20,
                                //             top: 10,
                                //             bottom: 10,
                                //           ),
                                //           border: OutlineInputBorder(
                                //             borderRadius:
                                //             BorderRadius.all(
                                //                 Radius.circular(90.0)),
                                //             borderSide: BorderSide.none,
                                //           ),
                                //           filled: true,
                                //           fillColor: Colors.grey[350],
                                //           hintText: LocaleKeys
                                //               .selectDatePlaceholder.tr(),
                                //           hintStyle: GoogleFonts.lato(
                                //             color: Colors.black26,
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w800,
                                //           ),
                                //         ),
                                //         controller: _dateController,
                                //         validator: (value) {
                                //           if (value.isEmpty)
                                //             return LocaleKeys
                                //                 .dateWarningPlaceholder.tr();
                                //           return null;
                                //         },
                                //         onFieldSubmitted: (String value) {
                                //           f5.unfocus();
                                //           FocusScope.of(context).requestFocus(
                                //               f6);
                                //         },
                                //         textInputAction: TextInputAction.next,
                                //         style: GoogleFonts.lato(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //       Padding(
                                //         padding: const EdgeInsets.only(
                                //             right: 5.0),
                                //         child: ClipOval(
                                //           child: Material(
                                //             color: kPrimaryBrightColor,
                                //             // button color
                                //             child: InkWell(
                                //               // inkwell color
                                //               child: SizedBox(
                                //                 width: 40,
                                //                 height: 40,
                                //                 child: Icon(
                                //                   Icons.date_range_outlined,
                                //                   color: Colors.white,
                                //                 ),
                                //               ),
                                //               onTap: () {
                                //                 selectDate(context);
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10,
                                ),
                                //OLD TIME PICKER
                                Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextFormField(
                                        focusNode: f6,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 20,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[350],
                                          hintText: LocaleKeys.timePlaceholder
                                              .tr(),
                                          hintStyle: GoogleFonts.lato(
                                            color: Colors.black26,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        controller: _dateController,
                                        validator: (value) {
                                          if (value.isEmpty)
                                            return LocaleKeys
                                                .dateWarningPlaceholder.tr();
                                          return null;
                                        },
                                        onFieldSubmitted: (String value) {
                                          f6.unfocus();
                                        },
                                        textInputAction: TextInputAction.next,
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            // button color
                                            child: InkWell(
                                              // inkwell color
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: kPrimaryBrightColor,
                                                ),
                                              ),
                                              onTap: () {
                                               // selectTime(context);
                                                if(dateDropdownValue == "Monday @ 4:30 PM"){
                                                  debugPrint("Monday");
                                                  selectDateMonday(context);
                                                } else if(dateDropdownValue == "Wednesday @ 1:45 PM"){
                                                  debugPrint("Wednesday");
                                                  selectDateWednesday(context);
                                                }else if(dateDropdownValue == "Thursday @ 7:00 PM"){
                                                  debugPrint("Thursday");
                                                  selectDateThursday(context);
                                                }else if(dateDropdownValue == "Friday @ 4:30 PM"){
                                                  debugPrint("Friday");
                                                  selectDateFriday(context);
                                                }else{
                                                  selectDate(context);
                                                }

                                              //  selectDate(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
SizedBox(height: 10),
                                //SIMONS TAME PICKER TESTING

                                // Container(
                                //   alignment: Alignment.center,
                                //   height: 60,
                                //   width: MediaQuery
                                //       .of(context)
                                //       .size
                                //       .width,
                                //   child: Stack(
                                //     alignment: Alignment.centerRight,
                                //     children: [
                                //       TextFormField(
                                //         focusNode: f6,
                                //         decoration: InputDecoration(
                                //           contentPadding: EdgeInsets.only(
                                //             left: 20,
                                //             top: 10,
                                //             bottom: 10,
                                //           ),
                                //           border: OutlineInputBorder(
                                //             borderRadius:
                                //             BorderRadius.all(
                                //                 Radius.circular(90.0)),
                                //             borderSide: BorderSide.none,
                                //           ),
                                //           filled: true,
                                //           fillColor: Colors.grey[350],
                                //           hintText: LocaleKeys.timePlaceholder
                                //               .tr(),
                                //           hintStyle: GoogleFonts.lato(
                                //             color: Colors.black26,
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w800,
                                //           ),
                                //         ),
                                //         controller: _timeController,
                                //         validator: (value) {
                                //           if (value.isEmpty)
                                //             return LocaleKeys
                                //                 .timeWarningPlaceholder.tr();
                                //           return null;
                                //         },
                                //         onFieldSubmitted: (String value) {
                                //           f6.unfocus();
                                //         },
                                //         textInputAction: TextInputAction.next,
                                //         style: GoogleFonts.lato(
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //       Padding(
                                //         padding: const EdgeInsets.only(
                                //             right: 5.0),
                                //         child: ClipOval(
                                //           child: Material(
                                //             color: kPrimaryBrightColor,
                                //             // button color
                                //             child: InkWell(
                                //               // inkwell color
                                //               child: SizedBox(
                                //                 width: 40,
                                //                 height: 40,
                                //                 child: Icon(
                                //                   Icons.check,
                                //                   color: Colors.white,
                                //                 ),
                                //               ),
                                //               onTap: () {
                                //                 selectTime(context);
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 40,
                                // ),
                                Container(
                                  height: 50,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      primary: kPrimaryColor,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            32.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        print(_nameController.text);
                                        print(_dateController.text);
                                        // print(widget.doctor);
                                        showAlertDialog(context);
                                        _createAppointment();
                                        //Submit user info
                                        _updateUserData();

                                        uploadPic(_image);
                                      }
                                    },
                                    child: Text(
                                      LocaleKeys.bookAppointmentPlaceholder
                                          .tr(),
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }else{
              return Container();
            }
          }else{
            return Scaffold(
              backgroundColor: Colors.white,
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  LocaleKeys.bookingPlaceholder.tr(),
                  style: GoogleFonts.lato(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              body: SafeArea(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return;
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage('assets/appointment.jpg'),
                          height: 250,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.only(top: 0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  LocaleKeys.patientDetailsPlaceholder.tr(),
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: _nameController,
                                focusNode: f1,
                                validator: (value) {
                                  if (value.isEmpty) return LocaleKeys
                                      .patientNamePlaceholder.tr();
                                  return null;
                                },
                                style: GoogleFonts.lato(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(
                                      left: 20, top: 10, bottom: 10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  // hintText: LocaleKeys.patientNameStarPlaceholder.tr(),
                                  hintText: user.displayName == null
                                      ? LocaleKeys
                                      .patientNameStarPlaceholder.tr()
                                      : user
                                      .displayName,
                                  hintStyle: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                onFieldSubmitted: (String value) {
                                  f1.unfocus();
                                  FocusScope.of(context).requestFocus(f2);
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                focusNode: f2,
                                controller: _phoneController,
                                style: GoogleFonts.lato(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(
                                      left: 20, top: 10, bottom: 10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  hintText:
                                 // getPhone(),
                                  LocaleKeys.patientMobileStarPlaceholder.tr(),

                                  // _phoneController.text == null
                                  //     ? LocaleKeys.patientMobileStarPlaceholder.tr()
                                  //     : _phoneController.text,
                                  hintStyle: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys.phoneEnterText.tr();
                                  } else if (value.length < 10) {
                                    return LocaleKeys.phoneErrorText.tr();
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (String value) {
                                  f2.unfocus();
                                  FocusScope.of(context).requestFocus(f3);
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                focusNode: f3,
                                controller: _descriptionController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: GoogleFonts.lato(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(
                                      left: 20, top: 10, bottom: 10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  hintText: LocaleKeys.descriptionPlaceholder
                                      .tr(),
                                  hintStyle: GoogleFonts.lato(
                                    color: Colors.black26,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return LocaleKeys.medicalWarningPlaceholder
                                        .tr();
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (String value) {
                                  f3.unfocus();
                                  FocusScope.of(context).requestFocus(f4);
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _doctorController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Please enter Number of Plants';
                                  return null;
                                },
                                style: GoogleFonts.lato(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(
                                      left: 20, top: 10, bottom: 10),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  hintText: LocaleKeys.numberOfPlantsPlaceholder
                                      .tr(),
                                  hintStyle: GoogleFonts.lato(
                                    color: Colors.black26,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextFormField(
                                      focusNode: f4,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 20,
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(90.0)),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[350],
                                        hintText: _image == null
                                            ? LocaleKeys
                                            .selectPhotoPlaceholder.tr()
                                            : _image
                                            .toString(),
                                        //hintText: LocaleKeys.selectPhotoPlaceholder.tr(),
                                        hintStyle:
                                        _image == null ?
                                        GoogleFonts.lato(
                                          color: Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ) :
                                        GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),

                                      ),
                                      //controller: _dateController,
                                      validator: (value) {
                                        if (_image == null)
                                          return LocaleKeys
                                              .photoIDWarningPlaceholder
                                              .tr();
                                        return null;
                                      },
                                      onFieldSubmitted: (String value) {
                                        f4.unfocus();
                                        FocusScope.of(context).requestFocus(f5);
                                      },
                                      textInputAction: TextInputAction.next,
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          // button color
                                          child: InkWell(
                                            // inkwell color
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: kPrimaryBrightColor,
                                              ),
                                            ),
                                            // onTap: () {
                                            // //  selectDate(context);
                                            //
                                            //  // _onImageButtonPressed(ImageSource.gallery, context: context);
                                            //   getImage();
                                            //
                                            // },
                                            onTap: getImage,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    DropdownButtonFormField(

                                      isExpanded: true,
                                      isDense: true,
                                      iconEnabledColor: kPrimaryBrightColor,
                                      icon:

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0),
                                        child: ClipOval(

                                          child:
                                          Material(
                                            color: Colors.transparent,
                                            child:
                                            InkWell(
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.timer,
                                                  color: kPrimaryBrightColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      focusNode: f5,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 20,
                                          // top: 10,
                                          //  bottom: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(90.0)),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[350],
                                        hintText: LocaleKeys
                                            .selectDatePlaceholder.tr(),
                                        hintStyle: GoogleFonts.lato(
                                          color: Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      //controller: _dateController,
                                      // validator: (value) {
                                      //   if (value.isEmpty)
                                      //     return LocaleKeys
                                      //         .dateWarningPlaceholder.tr();
                                      //   return null;
                                      // },
                                      onChanged: (String dateValue) {

                                        setState(() {
                                          dateDropdownValue = dateValue;
                                          debugPrint("DATE VALUE: $dateValue");
                                          debugPrint("DROP DOWN DATE VALUE: $dateDropdownValue");
                                          //debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");

                                          //PIE
                                          if(dateValue == "Monday @ 4:30 PM"){
                                            dateDropdownFinal = "16:30";
                                            debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                          }else if(dateValue == "Wednesday @ 1:45 PM"){
                                            dateDropdownFinal = "13:45";
                                            debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                          }else if(dateValue == "Thursday @ 7:00 PM"){
                                            dateDropdownFinal = "19:00";
                                            debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                          }else if(dateValue == "Friday @ 4:30 PM"){
                                            dateDropdownFinal = "16:30";
                                            debugPrint("DROP DOWN DATE VALUE: $dateDropdownFinal");
                                          }
                                        });
                                      },
                                      items: <String>[
                                        "Monday @ 4:30 PM",
                                        "Wednesday @ 1:45 PM",
                                        "Thursday @ 7:00 PM",
                                        "Friday @ 4:30 PM"
                                      ]
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(

                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0.0),
                                            child: Text("$value" , style: TextStyle(color: Colors.black),),
                                          ),
                                        );
                                      }).toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          print("VALUEEE $value");
                                          return LocaleKeys
                                              .dateWarningPlaceholder
                                              .tr();
                                        }
                                        return null;
                                      },
                                      // onFieldSubmitted: (String value) {
                                      //   f5.unfocus();
                                      //   FocusScope.of(context).requestFocus(
                                      //       f6);
                                      // },
                                      //textInputAction: TextInputAction.next,
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextFormField(
                                      focusNode: f5,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 20,
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(90.0)),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[350],
                                        hintText: LocaleKeys
                                            .selectDatePlaceholder.tr(),
                                        hintStyle: GoogleFonts.lato(
                                          color: Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      controller: _dateController,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return LocaleKeys
                                              .dateWarningPlaceholder.tr();
                                        return null;
                                      },
                                      onFieldSubmitted: (String value) {
                                        f5.unfocus();
                                        FocusScope.of(context).requestFocus(f6);
                                      },
                                      textInputAction: TextInputAction.next,
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          // button color
                                          child: InkWell(
                                            // inkwell color
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.date_range_outlined,
                                                color: kPrimaryBrightColor,
                                              ),
                                            ),
                                            onTap: () {
                                              if(dateDropdownValue == "Monday @ 4:30 PM"){
                                                debugPrint("Monday");
                                                selectDateMonday(context);
                                              } else if(dateDropdownValue == "Wednesday @ 1:45 PM"){
                                                debugPrint("Wednesday");
                                                selectDateWednesday(context);
                                              }else if(dateDropdownValue == "Thursday @ 7:00 PM"){
                                                debugPrint("Thursday");
                                                selectDateThursday(context);
                                              }else if(dateDropdownValue == "Friday @ 4:30 PM"){
                                                debugPrint("Friday");
                                                selectDateFriday(context);
                                              }else{
                                                selectDate(context);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextFormField(
                                      focusNode: f6,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                          left: 20,
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(90.0)),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[350],
                                        hintText: LocaleKeys.timePlaceholder
                                            .tr(),
                                        hintStyle: GoogleFonts.lato(
                                          color: Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      controller: _dateController,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return LocaleKeys
                                              .dateWarningPlaceholder.tr();
                                        return null;
                                      },
                                      onFieldSubmitted: (String value) {
                                        f6.unfocus();
                                      },
                                      textInputAction: TextInputAction.next,
                                      style: GoogleFonts.lato(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          // button color
                                          child: InkWell(
                                            // inkwell color
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.calendar_today_outlined,
                                                color: kPrimaryBrightColor,
                                              ),
                                            ),
                                            onTap: () {
                                              //selectTime(context);
                                              selectDate(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    primary: kPrimaryColor,
                                    onPrimary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      print(_nameController.text);
                                      print(_dateController.text);
                                      // print(widget.doctor);
                                      showAlertDialog(context);
                                      _createAppointment();
                                      //Submit user info
                                      _updateUserData();

                                      uploadPic(_image);
                                    }
                                  },
                                  child: Text(
                                    LocaleKeys.bookAppointmentPlaceholder.tr(),
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        //hereeee
      }
    );

  }

  Future<void> _createAppointment() async {
    debugPrint("CREATE APP DATE : $dateDropdownFinal");
    debugPrint("DATE TIME NOW PRINT : ${DateTime.now()}");
     if (((_nameController.text) == "") && ((_phoneController.text) == "")) {
      debugPrint("CREATE APPMNT NAME CONTROLLER NULL: ${_nameController.text}");
      debugPrint("name: ${_nameController.text}");
      debugPrint("phone: ${_phoneController.text}");
      debugPrint("desc: ${_descriptionController.text}");
      debugPrint("doctor: ${dropdownValue}");
      debugPrint("dropdown time: ${dateDropdownFinal}");
      debugPrint("date utc: ${dateUTC}");
      debugPrint("user email: ${user.email}");


     // print(dateUTC + ' ' + dateTime + ':00');
      FirebaseFirestore.instance
          .collection('appointments')
          .doc(user.email)
          .collection('pending')
          .doc()
          .set({
        'name': user.displayName,
        //'phone': _phoneController.text,
        'phone': _phone,
        'description': _descriptionController.text,
        'doctor': "${(dropdownValue.toString())} Plants",
        //'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
        'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
      }, SetOptions(merge: true));

      FirebaseFirestore.instance
          .collection('appointments')
          .doc(user.email)
          .collection('all')
          .doc()
          .set({
        'name': user.displayName,
        'phone': _phone,
        //'phone': "1111111111",
        'description': _descriptionController.text,
        'doctor': "${(dropdownValue.toString())} Plants",
        'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
      }, SetOptions(merge: true));
    } else if (((_nameController.text) == "") && ((_phoneController.text) != "")) {
       debugPrint("CREATE APPMNT NAME CONTROLLER NULL: ${_nameController.text}");
       debugPrint("name: ${_nameController.text}");
       debugPrint("phone: ${_phoneController.text}");
       debugPrint("desc: ${_descriptionController.text}");
       debugPrint("doctor: ${dropdownValue}");
       debugPrint("dropdown time: ${dateDropdownFinal}");
       debugPrint("date utc: ${dateUTC}");
       debugPrint("user email: ${user.email}");


       // print(dateUTC + ' ' + dateTime + ':00');
       FirebaseFirestore.instance
           .collection('appointments')
           .doc(user.email)
           .collection('pending')
           .doc()
           .set({
         'name': user.displayName,
         'phone': _phoneController.text,
         //'phone': _phone,
         'description': _descriptionController.text,
         'doctor': "${(dropdownValue.toString())} Plants",
         //'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
         'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
       }, SetOptions(merge: true));

       FirebaseFirestore.instance
           .collection('appointments')
           .doc(user.email)
           .collection('all')
           .doc()
           .set({
         'name': user.displayName,
         'phone': _phoneController.text,
         //'phone': "1111111111",
         'description': _descriptionController.text,
         'doctor': "${(dropdownValue.toString())} Plants",
         'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
       }, SetOptions(merge: true));
     }else if (((_nameController.text) != "") && ((_phoneController.text) == "")) {
       debugPrint("CREATE APPMNT NAME CONTROLLER NULL: ${_nameController.text}");
       debugPrint("name: ${_nameController.text}");
       debugPrint("phone: ${_phoneController.text}");
       debugPrint("desc: ${_descriptionController.text}");
       debugPrint("doctor: ${dropdownValue}");
       debugPrint("dropdown time: ${dateDropdownFinal}");
       debugPrint("date utc: ${dateUTC}");
       debugPrint("user email: ${user.email}");


       // print(dateUTC + ' ' + dateTime + ':00');
       FirebaseFirestore.instance
           .collection('appointments')
           .doc(user.email)
           .collection('pending')
           .doc()
           .set({
         'name': _nameController.text,
         'phone': _phone,
         //'phone': _phone,
         'description': _descriptionController.text,
         'doctor': "${(dropdownValue.toString())} Plants",
         //'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
         'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
       }, SetOptions(merge: true));

       FirebaseFirestore.instance
           .collection('appointments')
           .doc(user.email)
           .collection('all')
           .doc()
           .set({
         'name': _nameController.text,
         'phone': _phone,
         //'phone': "1111111111",
         'description': _descriptionController.text,
         'doctor': "${(dropdownValue.toString())} Plants",
         'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
       }, SetOptions(merge: true));
     }else if (((_nameController.text) != "") && ((_phoneController.text) != "")) {
       debugPrint("CREATE APPMNT NAME CONTROLLER NULL: ${_nameController.text}");
       debugPrint("name: ${_nameController.text}");
       debugPrint("phone: ${_phoneController.text}");
       debugPrint("desc: ${_descriptionController.text}");
       debugPrint("doctor: ${dropdownValue}");
       debugPrint("dropdown time: ${dateDropdownFinal}");
       debugPrint("date utc: ${dateUTC}");
       debugPrint("user email: ${user.email}");


       // print(dateUTC + ' ' + dateTime + ':00');
       FirebaseFirestore.instance
           .collection('appointments')
           .doc(user.email)
           .collection('pending')
           .doc()
           .set({
         'name': _nameController.text,
         'phone': _phoneController.text,
         //'phone': _phone,
         'description': _descriptionController.text,
         'doctor': "${(dropdownValue.toString())} Plants",
         //'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
         'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
       }, SetOptions(merge: true));

       FirebaseFirestore.instance
           .collection('appointments')
           .doc(user.email)
           .collection('all')
           .doc()
           .set({
         'name': _nameController.text,
         'phone': _phoneController.text,
         //'phone': "1111111111",
         'description': _descriptionController.text,
         'doctor': "${(dropdownValue.toString())} Plants",
         'date': DateTime.parse(dateUTC + ' ' + dateDropdownFinal + ':00'),
       }, SetOptions(merge: true));
     }
     else{
      print("Nothing!!!!");
    }
   // var _name =
   //  print(dateUTC + ' ' + dateTime + ':00');
   //  FirebaseFirestore.instance
   //      .collection('appointments')
   //      .doc(user.email)
   //      .collection('pending')
   //      .doc()
   //      .set({
   //     // 'name': (_nameController.text) ?? nameFirebase,
   //     'name': "Placeholder",
   //     'phone': _phoneController.text,
   //    'description': _descriptionController.text,
   //    'doctor': _doctorController.text,
   //    'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
   //  }, SetOptions(merge: true));
   //
   //  FirebaseFirestore.instance
   //      .collection('appointments')
   //      .doc(user.email)
   //      .collection('all')
   //      .doc()
   //      .set({
   //    // 'name': (_nameController.text) ?? nameFirebase,
   //    'name': "Placeholder",
   //    'phone': _phoneController.text,
   //    'description': _descriptionController.text,
   //    'doctor': _doctorController.text,
   //    'date': DateTime.parse(dateUTC + ' ' + dateTime + ':00'),
   //  }, SetOptions(merge: true));
  }


  Future<void> _updateUserData() async {
      print("DISPLAY NAMEEE : ${(user.displayName)}");
      print("NAME CONTROLLER : ${(_nameController.text)}");
      print("FIREBASE NAMEEEEEE : ${(nameFirebase)}");
      print("SAVED PHONE : ${(_phone)}");
     // print("SAVED PHONE : ${(setUserDetails(data))}");


      if((_nameController.text) == "" && (_phoneController.text) == "") {
        //nothing typed in in the name section
        // await user.updateProfile(displayName: (_nameController.text));
        FirebaseFirestore.instance.collection('users').doc(userID).set({
          // 'name': nameFirebase,
          'name': user.displayName,
          //plant #
          //'birthDate': _doctorController.text,
          'birthDate':  dropdownValue,
          'email': user.email,
          'phone': _phone,
          'bio': _descriptionController.text,
          'city': _image.toString(), //photo ID
        }, SetOptions(merge: true));

      }else if((_nameController.text) == "" && (_phoneController.text) != "") {
        //nothing typed in in the name section
        // await user.updateProfile(displayName: (_nameController.text));
        FirebaseFirestore.instance.collection('users').doc(userID).set({
          // 'name': nameFirebase,
          'name': user.displayName,
          //plant #
          //'birthDate': _doctorController.text,
          'birthDate':  dropdownValue,
          'email': user.email,
          'phone': _phoneController.text,
          'bio': _descriptionController.text,
          'city': _image.toString(), //photo ID
        }, SetOptions(merge: true));

      }
      else if ((_nameController.text) != "" && (_phoneController.text) == "") {
        await user.updateProfile(displayName: (_nameController.text));

        FirebaseFirestore.instance.collection('users').doc(userID).set({
          // 'name': (_nameController.text),
          'name': _nameController.text,
          //plant #
          //'birthDate': _doctorController.text,
          'birthDate':  dropdownValue,
          'email': user.email,
          'phone': _phone,
          'bio': _descriptionController.text,
          'city': _image.toString(), //photo ID
        }, SetOptions(merge: true));
      }     else if ((_nameController.text) != "" && (_phoneController.text) != "") {
        await user.updateProfile(displayName: (_nameController.text));

        FirebaseFirestore.instance.collection('users').doc(userID).set({
          // 'name': (_nameController.text),
          'name': _nameController.text,
          //plant #
          //'birthDate': _doctorController.text,
          'birthDate':  dropdownValue,
          'email': user.email,
          'phone': _phoneController.text,
          'bio': _descriptionController.text,
          'city': _image.toString(), //photo ID
        }, SetOptions(merge: true));
      }

      else{
        print("NOTHING");
      }


      // FirebaseFirestore.instance.collection('users')
      //     //.doc(user.uid).set({
      //         .doc(userID).set({
      //
      //   'name': _nameController,
      //   'birthDate': _dateController,
      //   'email': user.email,
      //   //'phone': null,
      //   'phone': _phoneController.text,
      //   'bio': _descriptionController,
      //   'city': _doctorController,
      // }, SetOptions(merge: true));




      // FirebaseFirestore.instance.collection('users').doc(userID).set({
      //   widget.field: _textcontroller.text,
      // }, SetOptions(merge: true));
      // if (widget.field.compareTo('name') == 0) {
      //   await user.updateProfile(displayName: _textcontroller.text);
      // }
      // if (widget.field.compareTo('phone') == 0) {
      // }
  }

  uploadPic(File _image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String url;
   // Reference ref = storage.ref().child("image" + DateTime.now().toString());
    Reference ref = storage.ref().child("${user.uid}");
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.whenComplete(() {
      url = ref.getDownloadURL() as String;
    }).catchError((onError) {
      print(onError);
    });
    return url;
  }

  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = basename(_imageFile.path);
  //   StorageReference firebaseStorageRef =
  //   FirebaseStorage.instance.ref().child('uploads/$fileName');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //   );
  // }

  _getPhone() {


    return
      StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData){
          print("HAS NO DATA");
          Text("No Data");
        }
        Text("No Data");
        if (snapshot.hasData){
          print("HAS DATA");
          var userData = snapshot.data;
          setState(() {
           // _phone = userData['phone'].toString();
          });
          Text(
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
          );
        }


       // );
      },
    );
  }

  setUserDetails(Map<String, dynamic> data) {
    debugPrint("DATA MAPPED : $data");
    debugPrint("DATA MAPPED KEY: ${data.values.elementAt(1)}");
setState(() {
  _phone = data.values.elementAt(1);
  debugPrint("ELEMENT 0 : ${data.values.elementAt(0)}");
  debugPrint("ELEMENT 1 : ${data.values.elementAt(1)}");
  debugPrint("ELEMENT 2 : ${data.values.elementAt(2)}");
  debugPrint("ELEMENT 3 : ${data.values.elementAt(3)}");
  debugPrint("ELEMENT 4 : ${data.values.elementAt(4)}");
  debugPrint("ELEMENT 5 : ${data.values.elementAt(5)}");
 // debugPrint("ELEMENT 6 : ${data.values.elementAt(6)}");
  debugPrint("PHONE FINALLLL: $_phone");
});
//debugPrint()
  }

}




