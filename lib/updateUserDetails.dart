import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:health_and_doctor_appointment/colors.dart';
import 'package:health_and_doctor_appointment/translations/“locale_keys.g.dart”';
import 'package:easy_localization/easy_localization.dart';

class UpdateUserDetails extends StatefulWidget {
  final String label;
  final String field;
  const UpdateUserDetails({Key key, this.label, this.field}) : super(key: key);

  @override
  _UpdateUserDetailsState createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  TextEditingController _textcontroller = TextEditingController();
  FocusNode f1;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  String userID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
    userID = user.uid;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: GoogleFonts.lato(
              color: kPrimaryColor,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userID)
                  .snapshots(),
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _textcontroller,
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    onFieldSubmitted: (String _data) {
                      _textcontroller.text = _data;
                    },
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please Enter the ' + widget.label;
                      return null;
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  updateData();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: kPrimaryColor.withOpacity(0.9),
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text(
                    LocaleKeys.updatePlaceholder.tr(),
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    FirebaseFirestore.instance.collection('users').doc(userID).set({
      widget.field: _textcontroller.text,
    }, SetOptions(merge: true));
    if (widget.field.compareTo('name') == 0) {
      await user.updateProfile(displayName: _textcontroller.text);
    }
    if (widget.field.compareTo('phone') == 0) {
    }
  }
}
