// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AnotherApi extends StatefulWidget {
  const AnotherApi({super.key});

  @override
  State<AnotherApi> createState() => _AnotherApiState();
}

class _AnotherApiState extends State<AnotherApi> {
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map json in data) {
        Photos photos =
            Photos(title: json['title'], url: json['url'], id: json['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos Api'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: getPhotos(),
              builder: (context, snapshot) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data![index].url)),
                          title: Text('Notes ID: ${snapshot.data![index].id}'),
                          subtitle: Text(snapshot.data![index].title),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
