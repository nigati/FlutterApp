import 'package:flutter/material.dart';
import 'package:flutter_app/services/userServices.dart';
import 'package:provider/provider.dart';

import '../models/route.dart';
import '../services/routeServices.dart';
import '../widgets/drawer.dart';

class ResultRoutes extends StatefulWidget {
  final String stopPoint;
  final String startPoint;
  final String dateStart;
  final String dateStop;
  const ResultRoutes(
      {super.key,
      required this.startPoint,
      required this.stopPoint,
      required this.dateStart,
      required this.dateStop});

  @override
  State<ResultRoutes> createState() => _ResultRoutesState();
}

class _ResultRoutesState extends State<ResultRoutes> {
  
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String>(
      future: downloadData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Center(
                child: new Text(
                    '${snapshot.data}')); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }

  Future<String> downloadData() async {
    /* var res = await routeService.getSearchedRoutes(
                            this..text,
                            stopPointController.text,
                            dateInputController.text,
                            startDate,
                            stopDate);   */
    return Future.value("Data download successfully"); // return your response
  }
}
