import 'dart:convert';

import 'package:flutter_app/models/user.dart';

List<Routes> routeFromJson(String str) =>
    List<Routes>.from(json.decode(str).map((x) => Routes.fromJson(x)));

String routeToJson(List<Routes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Routes {
  Routes(
      {
      //this.id = "", // non nullable but optional with a default value
      required this.name,
      this.id,
      required this.creator,
      required this.participants,
      required this.startPoint,
      required this.endPoint,
      required this.stopPoint,
      required this.dateOfBeggining,
      this.price});

  String? id;
  String name;
  User creator;
  List<User>? participants;
  String startPoint;
  String endPoint;
  List<String>? stopPoint;
  DateTime dateOfBeggining;
  double? price;

  factory Routes.fromJson(Map<String, dynamic> responseData) {
    List<User>? tmp1 = responseData["participants"] != null
        ? List<User>.from(
            responseData["participants"].map((x) => User.fromJson(x)))
        : null;
    List<String>? tmp2 = responseData["stopPoint"] != null
        ? List<String>.from(json.decode(responseData["stopPoint"]))
        : null;

    return Routes(
        id: responseData["_id"],
        name: responseData["name"],
        creator: User.fromJson(responseData['creator']), //mirar si esta bé
        participants: tmp1,
        startPoint: responseData["startPoint"],
        endPoint: responseData["endPoint"],
        stopPoint: tmp2,
        dateOfBeggining: responseData["dateOfBeggining"],
        price: responseData["price"]);
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "creator": creator,
        "participants": participants,
        "startPoint": startPoint,
        "endPoint": endPoint,
        "stopPoint": stopPoint,
        "price": price,
        "dateOfBeggining": dateOfBeggining
      };
}
