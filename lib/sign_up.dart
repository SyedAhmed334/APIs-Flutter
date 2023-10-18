import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    try {
      var response =
          await http.post(Uri.parse('https://reqres.in/api/register'), body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
      } else {
        print("account creation failed!");
      }
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign UP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  login(emailController.text, passwordController.text);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text('Sign Up'),
                )),
          ],
        ),
      ),
    );
  }
}
