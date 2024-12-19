
import 'package:flutter/material.dart';
import 'package:ultradine/utils/constants.dart';
import 'package:ultradine/utils/custom_appbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Constants.appName,
     /*   actions: [
          Icon(Icons.input)
        ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              homeWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeWidget() {
    return  Column(
      children: [
        Text(Constants.orderType),

      ],
    );
  }
}
