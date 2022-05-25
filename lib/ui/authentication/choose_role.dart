import 'package:flutter/material.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: ListView(
            children: <Widget>[
              Image.asset("assets/images/role.png",),
              const Text(
                "Choose Your Role",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ]
          )
        )
    );
  }
}
