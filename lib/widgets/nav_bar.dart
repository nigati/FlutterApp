import 'package:flutter/material.dart';
import 'package:flutter_app/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[buildHeader(context), buildItems(context)],
        )),
      );

  Widget buildHeader(BuildContext context) => SafeArea(
        child: Container(
          color: Color(0xFF4cbfa6),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 52,
              )
            ],
          ),
        ),
      );
  Widget buildItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text("My Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.cable),
              title: const Text("My Routes"),
              onTap: () {},
            )
          ],
        ),
      );

  getShared(String key) async {
    final shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }
}
