import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Chat extends StatefulWidget {
  var chatroomkey;
  var shop;
  var user;
  Chat({@required this.chatroomkey, @required this.shop, @required this.user});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _MessageController = new TextEditingController();
  final storemessage = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    UpdateDetails() {
      CollectionReference _CollectionReference =
          FirebaseFirestore.instance.collection("Chats");
      return _CollectionReference.doc(widget.chatroomkey).set({
        "shop": widget.shop,
        "user": widget.user,
        "chatroomid": widget.chatroomkey,
        "Time": DateTime.now().toString(),
      });
    }

    final Size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("7 Star Traders"),
        centerTitle: true,
        toolbarHeight: height * 0.09,
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Chats")
                    .doc(widget.chatroomkey)
                    .collection("messages")
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      primary: true,
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot x = snapshot.data!.docs[i];
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: widget.shop != x['User']
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              SafeArea(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: widget.user != x['User']
                                              ? Colors.white
                                              : Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          x['Messages'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))),
                              Text(
                                widget.user != x['User'] ? x['User'] : "You",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
                      });
                }),
          )),
          Card(
            color: Color.fromARGB(255, 253, 240, 203),
            child: TextFormField(
              controller: _MessageController,
              textAlignVertical: TextAlignVertical.center,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "Send A Message",
                  suffix: IconButton(
                      onPressed: () {
                        if (_MessageController.text.isNotEmpty) {
                          storemessage
                              .collection("Chats")
                              .doc(widget.chatroomkey)
                              .collection("messages")
                              .doc()
                              .set({
                            "Messages": _MessageController.text.trim(),
                            "User": FirebaseAuth.instance.currentUser!.email,
                            'time': DateTime.now()
                          }).then((value) {
                            UpdateDetails();
                          });
                          _MessageController.clear();
                        }
                      },
                      icon: Icon(Icons.send))),
            ),
          ),
        ],
      ),
    );
  }
}
