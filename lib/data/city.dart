import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class City {
  int? code; // Thêm dòng này

  String name;
  String? codename;
  String? divisionType;
  int? phoneCode;
  List<District>? districts;

  City({
    required this.name,
    this.code,
    this.codename,
    this.divisionType,
    this.phoneCode,
    this.districts,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      code: json['code'], // Thêm dòng này
      name: json['name'],
      codename: json['codename'],
      divisionType: json['division_type'],
      phoneCode: json['phone_code'],
      districts: json['districts'] != null
          ? List<District>.from(
        json['districts'].map((district) => District.fromJson(district)),
      )
          : null,
    );
  }
}

class District {
  int? code;
  final String name;
  final List<Ward> wards;

  District({required this.name, required this.wards, required code});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['name'],
      wards: (json['wards'] as List).map((ward) => Ward.fromJson(ward)).toList(),
      code: json['code'],
    );
  }
}

class Ward {
  int? code;
  String name;

  Ward({
    required this.name,
    this.code,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      name: json['name'],
      code: json['code'],
    );
  }
}