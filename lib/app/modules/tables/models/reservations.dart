
import 'dart:convert';

import 'package:equatable/equatable.dart';

Reservation reservationFromJson(String str) => Reservation.fromJson(json.decode(str));

String reservationToJson(Reservation data) => json.encode(data.toJson());

class Reservation extends Equatable{
 const Reservation({
    required this.userId,
    required this.tableId,
    required this.id,
  });

 final int userId;
  final int tableId;
  final int id;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    userId: json["user_id"],
    tableId: json["table_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "table_id": tableId,
    "id": id,
  };

  @override
  List<Object?> get props => [];
}