import 'package:flutter/material.dart';
import 'package:flutter_app/models/route.dart';
import 'package:flutter_app/services/routeServices.dart';
import 'package:flutter_app/services/userServices.dart';
import 'package:flutter_app/views/first_page.dart';
import 'package:flutter_app/views/route_info.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/drawer.dart';

class MyRoutesPage extends StatefulWidget {
  const MyRoutesPage(
      {super.key,
});

  @override
  State<MyRoutesPage> createState() => _MyRoutesPage();
}

class _MyRoutesPage extends State<MyRoutesPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserServices userprovider = Provider.of<UserServices>(context);

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
          itemCount: userprovider.userData.routes!.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0xFF4cbfa6),
              child: ListTile(
                title: Text(userprovider.userData.routes![index].name),
                subtitle: Text(
                    "Inicio:${userprovider.userData.routes![index].startPoint}| Final: ${userprovider.userData.routes![index].endPoint}"),
                trailing: SizedBox(
                    width: 120,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.article),
                            onPressed: () {
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
