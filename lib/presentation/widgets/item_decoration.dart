import 'package:flutter/material.dart';
import '../../app/config/config.dart';

BoxDecoration selectedDecoration(){
  return  BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: ColorResources.primary, width: 2),
    gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colors.white,ColorResources.primary]),
  );
}

BoxDecoration selectedTabDecoration(){
  return  BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: ColorResources.primary, width: 3 ),
    gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colors.white,ColorResources.primary]),
  );
}

BoxDecoration unselectedDecoration(){
  return  BoxDecoration(
    color: ColorResources.lightBg,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: ColorResources.primary,
        blurRadius: 1.0,
        spreadRadius: 0.4,
        offset: Offset(0, 2.0), // bottom shadow
      ),
    ],
  );
}

BoxDecoration unselectedTabDecoration(){
  return  BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: ColorResources.stroke, width: 3 ),
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colors.white,ColorResources.lightBg]),
  );
}