import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      setState(() {});
    } else {
      print('image not picked');
    }
  }

  Future uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var url = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', url);
    request.fields['title'] = "this title";
    var multipart = http.MultipartFile('image', stream, length);
    request.files.add(multipart);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('image uploaded');
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: getImage,
              child: Container(
                child: image == null
                    ? Container(
                        child: Center(child: Text('Pick image')),
                      )
                    : Container(
                        child: Image.file(
                          File(image!.path).absolute,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: uploadImage,
              child: Container(
                height: 50,
                width: 200,
                color: Colors.green,
                child: Center(child: Text('Upload Image')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
