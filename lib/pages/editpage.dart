// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  var id;
  // var price;
  Edit({super.key, required this.id});
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController city = TextEditingController();
  var tap = "";
  String? cit;
  bool click = false;
  senddata() {
    CollectionReference c = FirebaseFirestore.instance
        .collection("Seller_req")
        .doc("A3YtV51DsJGf7ruoFV6x")
        .collection("item");
    return c.doc(widget.id["id"]).update({"city": cit}).then((value) {
      print("send");
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController tet = TextEditingController();

    tet.text = widget.id["email"];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: tet,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  _ontap();
                });
              },
              child: click == false
                  ? Container(
                      color: Colors.red,
                      height: 40,
                      width: 200,
                      child: Text(widget.id['city']))
                  : Column(children: [
                      TextField(
                        controller: tet,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            print(tet.text);
                            setState(() {
                              cit = tet.text;
                              _ontap();
                            });

                            senddata();
                          },
                          child: const Text("update"))
                    ]))
        ],
      ),
    );
  }

  void _ontap() {
    click = !click;
  }
}
