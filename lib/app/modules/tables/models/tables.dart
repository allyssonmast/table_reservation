

import 'dart:convert';

import 'package:equatable/equatable.dart';

Tables tableFromJson(String str) => Tables.fromJson(json.decode(str));

String tableToJson(Tables data) => json.encode(data.toJson());

class Tables extends Equatable{
 const Tables({
    required this.shape,
    required this.id,
  });

  final String shape;
  final int id;

  factory Tables.fromJson(Map<String, dynamic> json) => Tables(
    shape: json["shape"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "shape": shape,
    "id": id,
  };

  @override
  List<Object?> get props => [];
}
