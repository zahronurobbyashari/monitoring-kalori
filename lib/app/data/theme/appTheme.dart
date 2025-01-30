// ignore_for_file: file_names, unused_import, deprecated_member_use, empty_constructor_bodies, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_dialogs/material_dialogs.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: const Color(0xffFC9F00),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xffFDCE00), // Your accent color
  ),
  canvasColor: const Color(0xffEFEFEF),
  // backgroundColor: const Color(0xffEFEFEF),
  hintColor: const Color(0xff101010),
);

class FormHelper {
  InputDecoration textInputDecoration(
      [String labelText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: appThemeData.canvasColor,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      floatingLabelStyle: const TextStyle(color: Colors.grey),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    );
  }

  BoxDecoration buttonBoxDecoration(
    BuildContext context,
  ) {
    return BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 4),
          blurRadius: 5.0,
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [appThemeData.primaryColor, appThemeData.colorScheme.secondary],
      ),
      color: appThemeData.primaryColor,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(
        const Size(50, 50),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AppBar appBar([String title = "", String hintText = ""]) {
    return AppBar(
      title: Text(title),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0],
            colors: [
              appThemeData.primaryColor,
              appThemeData.colorScheme.secondary
            ],
          ),
        ),
      ),
    );
  }
}
