import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class update_record extends StatefulWidget {
  String name;
  String email;
  String password;
  update_record(this.name, this.email, this.password);

  @override
  State<update_record> createState() => _update_recordState();
}

class _update_recordState extends State<update_record> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> updaterecord() async {
    try {
      String uri = "http://192.168.1.16/practice/update_data.php";
      var res = await http.post(Uri.parse(uri), body: {
        "name": name.text,
        "email": email.text,
        "password": password.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("updated");
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    name.text = widget.name;
    email.text = widget.email;
    password.text = widget.password;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Update Record')),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Enter the Name')),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Enter the Email')),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter the Password')),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                updaterecord();
              },
              child: Text('Update'),
            ),
          ),
        ]));
  }
}
