// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:apis_flutter/another_example_api.dart';
import 'package:apis_flutter/product_page.dart';
import 'package:apis_flutter/sign_up.dart';
import 'package:apis_flutter/upload_image.dart';
import 'package:flutter/material.dart';

import 'Models/posts_model.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    home: UploadImage(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<PostsModel> postsList = [];
  Future<List<PostsModel>> getPosts() async {
    var response =
        await get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postsList.add(PostsModel.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPosts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Loading');
                  } else {
                    return ListView.builder(
                      itemCount: postsList.length,
                      itemBuilder: (context, index) => Text(index.toString()),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
