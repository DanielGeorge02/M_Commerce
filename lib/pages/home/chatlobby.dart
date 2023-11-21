// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_commerce/pages/chat.dart';

class ChatLobby extends StatefulWidget {
  const ChatLobby({super.key});

  @override
  State<ChatLobby> createState() => _LobbyState();
}

class _LobbyState extends State<ChatLobby> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          centerTitle: true,
          toolbarHeight: height * 0.09,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              color: Colors.white),
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Chats")
                  .orderBy('Time')
                  .snapshots(),
              builder: (context, snapshot) {
                var Email = FirebaseAuth.instance.currentUser!.email;
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      QueryDocumentSnapshot x = snapshot.data!.docs[i];

                      if (x['user'] == Email) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              child: Center(
                                child: Text(x["shop"].toString().toUpperCase()),
                              ),
                            ),
                            // leading: Icon(
                            //   Icons.person,
                            //   size: 40,
                            // ),
                            title: const Text(
                              // x['shop'],
                              "7 Stars Traders",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: const Text("Message"),
                            onTap: () {
                              // print(x['shop']);
                              // print(x['user']);
                              // print(x['chatroomkey']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat(
                                          shop: x['shop'],
                                          user: x['user'],
                                          chatroomkey: x['chatroomid'])));
                            },
                          ),
                        );
                      } else if (x['shop'] == Email) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading: const Icon(
                              Icons.person,
                              size: 40,
                            ),
                            title: Text(
                              x['user'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: const Text("Message"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat(
                                          shop: x['shop'],
                                          user: x['user'],
                                          chatroomkey: x['chatroomid'])));
                            },
                          ),
                        );
                      }

                      return Container();
                    });
              }),
        ));
  }
}
