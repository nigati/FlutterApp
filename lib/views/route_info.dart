import 'package:flutter/material.dart';
import 'package:flutter_app/services/routeServices.dart';
import 'package:flutter_app/services/userServices.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/drawer.dart';

class RouteInfo extends StatefulWidget {
  const RouteInfo({super.key});

  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RouteInfo> {
  @override
  Widget build(BuildContext context) {
    RouteServices _routeprovider = Provider.of<RouteServices>(context);
    UserServices _userprovider = Provider.of<UserServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text(_routeprovider.routeData.name),
        backgroundColor: const Color(0xFF4cbfa6),
      ),
      body: SizedBox(
        width: 900,
        height: 701,
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 100,
              child: Text(_routeprovider.routeData.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 300,
              height: 100,
              child: Text(_routeprovider.routeData.creator.name,
                  style: const TextStyle(fontSize: 16)),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 40, bottom: 10, left: 20, right: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://img.freepik.com/vector-premium/vista-superior-3d-mapa-punto-ubicacion-destino-vista-superior-limpia-aerea-mapa-ciudad-dia-calle-rio-mapa-imaginacion-urbana-blanco-concepto-navegador-mapas-gps-ilustracion-vectorial_34645-1264.jpg?w=2000"),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Text(_routeprovider.routeData.startPoint,
                      style: const TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Text(_routeprovider.routeData.endPoint,
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
            Row(children: <Widget>[
              TextButton(
                onPressed: () async {
                  _routeprovider.newParticipant(
                      _routeprovider.routeData, _userprovider.userData);
                  _routeprovider.newRouteInUser(
                      _routeprovider.routeData, _userprovider.userData);
                  /*  _routeprovider.newBooking(_routeprovider.routeData,
                      _userprovider.userData, "selectedStopPoint"); */
                  Navigator.pop(context);
                },
                child: const Text(
                  'JOIN IN',
                  style: TextStyle(color: Color(0xFF4cbfa6), fontSize: 25),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Color(0xFF4cbfa6), fontSize: 25),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
