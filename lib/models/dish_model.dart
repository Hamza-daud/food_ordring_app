// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DishModel {
  final String id;
  final String dishname;
  final String DishDiscripition;
  final int dishprice;
  final String dishimage;

  DishModel(
    this.id,
    this.dishname,
    this.DishDiscripition,
    this.dishprice,
    this.dishimage,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dishname': dishname,
      'DishDiscripition': DishDiscripition,
      'dishprice': dishprice,
      'dishimage': dishimage,
    };
  }

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      map['id'] as String,
      map['dishname'] as String,
      map['DishDiscripition'] as String,
      map['dishprice'] as int,
      map['dishimage'] as String,
    );
  }
}
