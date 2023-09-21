import 'package:flutter/material.dart';

import '../helper/constant.dart';

@immutable
class AppState {
  final String image;
  final String email;
  final String password;
  final bool isRememberMeChecked;
  final List<String> skills;
  final List<String> workExperience;

  const AppState(
      {
        this.image ="",
        this.email = "",
      this.password = "",
      this.isRememberMeChecked = false,
      this.skills = const ['Kotlin', 'Java', 'Android', 'Flutter', 'Dart'],
      this.workExperience = const [
        'ABC Company Ltd',
        'XYZ Company Pvt Ltd',
        'NBC Pvt Ltd',
        'AA Pvt Ltd',
        'BBB Pvt Ltd'
      ]});

  AppState copyWith({
    String? image,
    String? email,
    String? password,
    bool? isRememberMeChecked,
    List<String>? skills,
    List<String>? workExperience,
  }) {
    return AppState(
      image: image ?? this.image,
      email: email ?? this.email,
      password: password ?? this.password,
      isRememberMeChecked: isRememberMeChecked ?? this.isRememberMeChecked,
      skills: skills ?? this.skills,
      workExperience: workExperience ?? this.workExperience,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'email': email,
      'password': this.password,
      'isRememberMeChecked': this.isRememberMeChecked,
      'skills': this.skills,
      'workExperience': this.workExperience,
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      image: map['image'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      isRememberMeChecked: map['isRememberMeChecked'] as bool,
      skills: map['skills'] as List<String>,
      workExperience: map['workExperience'] as List<String>,
    );
  }
}
