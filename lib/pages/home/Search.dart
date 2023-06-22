import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m_commerce/pages/home/result.dart';
import 'package:m_commerce/pages/viewproduct.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _search;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        toolbarHeight: height * 0.09,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          SizedBox(
            width: width * 0.75,
            child: TextFormField(
                autofocus: true,
                onChanged: ((value) {
                  setState(() {
                    _search = value;
                  });
                }),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search products",
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))))),
          ),
        ]),
      ),
      body: Stack(children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Seller_req')
                .doc("A3YtV51DsJGf7ruoFV6x")
                .collection("item")
                .where('PnameController', isEqualTo: _search)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (_search != null) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      String _name =
                          snapshot.data?.docs[index]['PnameController'];
                      String img = snapshot.data?.docs[index]['image'];

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(_name),
                            leading: Image.network(
                              img,
                              height: 100,
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Result()));
                            },
                          ),
                        ),
                      );
                    });
              } else {
                return Container();
              }
            }),
        Center(
          child: LottieBuilder.network(
              "https://assets10.lottiefiles.com/packages/lf20_yhetm7ld.json"),
        ),
      ]),
    );
  }
}
