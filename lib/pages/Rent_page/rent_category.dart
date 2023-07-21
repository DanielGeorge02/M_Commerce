import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/Rent_page/rent_viewproduct.dart';

class Rent_category extends StatefulWidget {
  Rent_category({super.key, this.category});
  var category;
  @override
  State<Rent_category> createState() => _Rent_categoryState();
}

class _Rent_categoryState extends State<Rent_category>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(widget.category,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: 410,
            color: Colors.amber,
            child: AnimatedBackground(
              behaviour: RandomParticleBehaviour(
                  options: const ParticleOptions(
                spawnMaxRadius: 20,
                spawnMinSpeed: 50,
                particleCount: 50,
                spawnMaxSpeed: 80,
                minOpacity: 0.7,
                maxOpacity: 0.9,
                baseColor: Colors.white,
              )),
              vsync: this,
              child: AnimatedTextKit(
                  repeatForever: true,
                  displayFullTextOnTap: true,
                  pause: Duration(milliseconds: 1000),
                  animatedTexts: [
                    RotateAnimatedText(
                      "Wanna rent " + widget.category,
                      textAlign: TextAlign.center,
                      textStyle: GoogleFonts.bebasNeue(
                          fontSize: 35, fontWeight: FontWeight.w800),
                    ),
                    RotateAnimatedText(
                      "at Lowest Price!",
                      textStyle: GoogleFonts.bebasNeue(
                          fontSize: 35, fontWeight: FontWeight.w800),
                    ),
                    RotateAnimatedText(
                      "Check it out!",
                      textStyle: GoogleFonts.bebasNeue(
                          fontSize: 35, fontWeight: FontWeight.w800),
                    )
                  ]),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Rent_upload_products")
                      .doc("AllProducts")
                      .collection("item")
                      .where("RcategoryController", isEqualTo: widget.category)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: Text(
                        "Loading...",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ));
                    }
                    return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 20,
                              childAspectRatio: 0.73),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        if (widget.category ==
                            documentSnapshot['RcategoryController']) {
                          // ignore: curly_braces_in_flow_control_structures
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Rent_viewproduct(
                                            oneday: documentSnapshot[
                                                "RonedayController"],
                                            name: documentSnapshot[
                                                "RPnameController"],
                                            image: documentSnapshot["image"],
                                            address: documentSnapshot[
                                                'RAddrController'],
                                            quantity: documentSnapshot[
                                                "RQuantityController"],
                                            description: documentSnapshot[
                                                'RPdesController'],
                                            oneweek: documentSnapshot[
                                                "RoneweekController"],
                                            twoweek: documentSnapshot[
                                                "RtwoweekController"],
                                            threeweek: documentSnapshot[
                                                "RthreeweekController"],
                                            onemonth: documentSnapshot[
                                                "RonemonthController"],
                                            threemonth: documentSnapshot[
                                                "RthreemonthController"],
                                            sixmonth: documentSnapshot[
                                                "RsixmonthController"],
                                            twelvemonth: documentSnapshot[
                                                "RtwelvemonthController"],
                                            // category: documentSnapshot[
                                            //     'RcategoryController'],
                                          ))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 160,
                                        color: Colors.white,
                                        child: CachedNetworkImage(
                                          imageUrl: documentSnapshot["image"],
                                        )),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 70,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: Text(documentSnapshot[
                                            "RPnameController"]),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text.rich(
                                          TextSpan(
                                              text: "${'\u{20B9}' +
                                                  documentSnapshot[
                                                      "RonedayController"]} per day",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }
                      },
                    );
                  })),
        ],
      ),
    );
  }
}
