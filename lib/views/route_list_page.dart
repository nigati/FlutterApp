import 'package:flutter/material.dart';
import 'package:flutter_app/models/route.dart';
import 'package:flutter_app/services/routeServices.dart';
import 'package:flutter_app/services/userServices.dart';
import 'package:flutter_app/views/first_page.dart';
import 'package:flutter_app/views/route_info.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/drawer.dart';

class RouteListPage extends StatefulWidget {
  const RouteListPage(
      {super.key,
});

  @override
  State<RouteListPage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RouteListPage> {
  //RouteServices routeService = RouteServices();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserServices userprovider = Provider.of<UserServices>(context);
    RouteServices routeprovder = Provider.of<RouteServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text('Available Routes'),
        backgroundColor: const Color(0xFF4cbfa6),
      ),
      body: Visibility(
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: routeprovder.listRoute.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xFF4cbfa6),
              child: ListTile(
                title: Text(routeprovder.listRoute[index].name),
                subtitle: Text(
                    "Inicio:${routeprovder.listRoute[index].startPoint}| Final: ${routeprovder.listRoute[index].endPoint}"),
                trailing: SizedBox(
                    width: 120,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.article),
                            onPressed: () {
                              routeprovder
                                  .setRouteData(routeprovder.listRoute[index]);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const RouteInfo()));
                            },
                            tooltip: 'Details',
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.home),
                            tooltip: 'Main',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const FirstPage()));
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}

showDialogFunc(context, name, email, id) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFF4cbfa6),
              ),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "USER DETAILS:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF4cbfa6),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "NAME : $name",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4cbfa6),
                      ),
                    ),
                    Text(
                      "EMAIL : $email",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4cbfa6),
                      ),
                    ),
                    const Text(
                      " ID : id",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF4cbfa6),
                      ),
                    )
                  ]),
            ),
          ),
        );
      });
}
