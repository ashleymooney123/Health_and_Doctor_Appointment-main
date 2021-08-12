import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/updateUserDetails.dart';
import 'package:health_and_doctor_appointment/translations/“locale_keys.g.dart”';
import 'package:easy_localization/easy_localization.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  List labelName = [
    LocaleKeys.namePlaceholder.tr(),
    LocaleKeys.emailPlaceholder.tr(),
    LocaleKeys.phonePlaceholder.tr(),
    LocaleKeys.bioPlaceholder.tr(),
    LocaleKeys.birthdayPlaceholder.tr(),
    LocaleKeys.cityPlaceholder.tr(),
  ];

  List value = [
    'name',
    'email',
    'phone',
    'bio',
    'birthDate',
    'city',
  ];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: StreamBuilder(
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
          return Column(
            children: [
              ListView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  5,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateUserDetails(
                                      label: labelName[index],
                                      field: value[index],
                                    )));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          height: MediaQuery.of(context).size.height / 14,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                labelName[index],
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userData[value[index]]?.isEmpty ?? true
                                    ? LocaleKeys.notAddedPlaceholder.tr()
                                    : userData[value[index]],
                                style: GoogleFonts.lato(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateUserDetails(
                            label: labelName[5],
                            field: value[5],
                          )));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    height: MediaQuery.of(context).size.height / 14,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          labelName[5],
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData[value[5]]?.isEmpty ?? true
                              ? LocaleKeys.notAddedPlaceholder.tr()
                              : userData[value[5]],
                          style: GoogleFonts.lato(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
