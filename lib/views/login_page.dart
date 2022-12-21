import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/route.dart';
import 'package:flutter_app/services/routeServices.dart';
import 'package:flutter_app/services/userServices.dart';
import 'package:flutter_app/views/route_list_page.dart';
import 'package:flutter_app/views/register.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/views/first_page.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool buttonEnabled = false;
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Incorrect credentials",
        style: TextStyle(color: Colors.red),
      ),
      content: const Text("User not found or incorrect password."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    RouteServices routeService = Provider.of<RouteServices>(context);
    UserServices userService = Provider.of<UserServices>(context);

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/gray-abstract-wireframe-technology-background_53876-101941.webp'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35, top: 130),
                  child: Text(
                    'Welcome\nBack',
                    style: TextStyle(color: Colors.black, fontSize: 45),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextField(
                                controller: usernameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextField(
                                controller: passwordController,
                                style: TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign in',
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: TextButton(
                                      onPressed: () async {
                                        if ((usernameController
                                                .text.isNotEmpty) &&
                                            (passwordController
                                                .text.isNotEmpty)) {
                                          setState(() {
                                            buttonEnabled = true;
                                          });
                                          print(usernameController.text +
                                              passwordController.text);
                                          var res = await userService.logIn(
                                              usernameController.text,
                                              passwordController.text);
                                          if (res == "401") {
                                            showAlertDialog(context);
                                            return;
                                          }
                                          if (res == "200") {
                                            RouteServices.getRoutes()
                                                .then((response) {
                                                  routeService
                                                .setListRouteData(response);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RouteListPage()));
                                                });
                                            
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'HERE',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage()));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
