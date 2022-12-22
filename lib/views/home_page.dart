import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';
import '../services/routeServices.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final startPointController = TextEditingController();
  final stopPointController = TextEditingController();
  final dateInputController = TextEditingController();
  //RouteServices routeprovder = Provider.of<RouteServices>(context);
  @override
  Widget build(BuildContext context) {
    RouteServices routeprovder = Provider.of<RouteServices>(context);
    return Scaffold(
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 200, 200, 200),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  flex: 2,
                  child: TextField(
                    controller: startPointController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "To",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  )),
              Flexible(
                  flex: 2,
                  child: TextField(
                    controller: stopPointController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "To",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  )),
              Flexible(
                  flex: 2,
                  child: DateTimePicker(
                    controller: dateInputController,
                    type: DateTimePickerType.date,
                    initialValue: DateTime.now().toString(),
                    dateMask: 'd MMM yyyy',
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Select date',
                    onChanged: (val) => print(val),
                    validator: (value) {
                      print(value);
                      return null;
                    },
                    onSaved: (newValue) => print(newValue),
                  )),
              Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () async {
                      routeprovder.getSearchedRoutes(startPointController.text,
                          stopPointController.text, dateInputController.text);
                    },
                    child: Text('Search'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
