import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/route.dart';
import 'package:flutter_app/models/user.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';

class RouteServices extends ChangeNotifier {
  Routes _routeData = Routes(
      name: "",
      id: "",
      creator: User(name: "", id: "", password: "", email: "", admin: false),
      participants: [],
      startPoint: "",
      endPoint: "",
      stopPoint: [],
      dateOfBeggining: DateTime(2017));

  Routes get routeData => _routeData;
  final LocalStorage storage = LocalStorage('key');
  void setRouteData(Routes routeData) {
    _routeData = routeData;
  }

  List<Routes> _listRoute = [];
  List<Routes> get listRoute => _listRoute;

  void setListRouteData(List<Routes> listRoute) {
    _listRoute = listRoute;
  }

  static Future<List<Routes>> getRoutes() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/routes');
    var response = await client.get(uri);
    List<Routes> rec = [];
    if (response.statusCode == 200) {
      var decodedList = (json.decode(response.body) as List<dynamic>);
       rec = decodedList.map((i) => Routes.fromJson(i)).toList();
      return rec;
    }
    else{
      return rec;
    }
    
  }

  Future<List<Routes>?> getSearchedRoutes(
      String start, String stop, String dateStart, String dateStop) async {
    var msg = jsonEncode({
      "start": start,
      "stop": stop,
      "dateInit": dateStart,
      "dateStop": dateStop
    });
    print(msg);
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/routes/search');
    var response = await client.post(uri,
        headers: {'content-type': 'application/json'}, body: msg);
    if (response.statusCode == 200) {
      var json = response.body;
      print(response.body);
      return routeFromJson(json);
    }
    return null;
  }

  Future<String> newParticipant(Routes nRoute, User part) async {
    final Map<String, dynamic> registerData = {
      'id': nRoute.id,
      'participant': part
    };
    try {
      Response response = await post(
        Uri.parse('http://localhost:5432/api/routes/newParticipant'),
        body: json.encode(registerData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        //Convert from json List of Map to List of Student
        return "200";
      } else {
        return "400";
      }
    } catch (err) {
      return "300";
    }
  }

  Future<String> newRoute(Routes nRoute, User part) async {
    final Map<String, dynamic> registerData = {
      'id': nRoute.id,
      'creator': part.name,
      'startPoint': nRoute.startPoint,
      'endPoint': nRoute.endPoint,
      'stopPoint': nRoute.stopPoint,
      'dateOfBeggining': nRoute.dateOfBeggining
    };
    try {
      Response response = await post(
        Uri.parse('http://localhost:5432/api/routes/newParticipant'),
        body: json.encode(registerData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        //Convert from json List of Map to List of Student
        Map<String, dynamic> responseData = jsonDecode(response.body);
        Routes newR = Routes.fromJson(responseData);
        _listRoute.add(newR);
        return "200";
      } else {
        return "400";
      }
    } catch (err) {
      return "300";
    }
  }

  Future<String> newRouteInUser(Routes nRoute, User part) async {
    final Map<String, dynamic> registerData = {'id': part.id, 'route': nRoute};
    try {
      Response response = await post(
        Uri.parse('http://localhost:5432/api/routes/newRouteInUser'),
        body: json.encode(registerData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        //Convert from json List of Map to List of Student
        return "200";
      } else {
        return "400";
      }
    } catch (err) {
      return "300";
    }
  }

  Future<String> newBooking(
      Routes nRoute, User part, String selectedStopPoint) async {
    final Map<String, dynamic> registerData = {
      'id': part.name,
      'route': nRoute.name,
      'price': nRoute.price,
      'selectedStopPoint': selectedStopPoint,
    };
    try {
      Response response = await post(
        Uri.parse('http://localhost:5432/api/bookings/create'),
        body: json.encode(registerData),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return "200";
      } else {
        return "400";
      }
    } catch (err) {
      return "300";
    }
  }
}
