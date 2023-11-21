// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names, duplicate_ignore

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/home/home.dart';
import 'categoryPage.dart';

class SeeAll extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var category;

  SeeAll({super.key, this.category});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  // ignore: non_constant_identifier_names
  String? area = "Search products in your Area";

  List Furniture = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMGLfEHJGwlYDOJ1aqlq_vmz33IenmvnKMRg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWNuZ1savrgXaFVMefqk1QD1BqH37j5bLEpw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk9Wi-kifTaqUuYZrqQ-ZYsTwgaZShBl9wmw&usqp=CAU"
  ];
  List Electronics = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTeoTXpBpnEtV_yDBcZpDLbni_Nq4Nci08zWdvYXZgyMdi4_ID-poKsJqst3OyOBi2NfA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRx-_7JJ4lAHIxsgQzfYwkEvQ1_2iDi0Wv7UQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPyeXuCB0sGdVroe7Ob8i91eAnqEws6BCA3g&usqp=CAU"
  ];
  List Mobiles = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF2aT9rAw4Yy_pOnidQ0n3nbH6gMK9PW3Dww&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhlYmKksiR0Vof4Ic0Ah68COBNwh2TNv4Z5g&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCSU_Hjana7nQo54ceWaj0UMSjvRqvyDzxFLEmKCkpNtWJDlM5klaxqSV1TEnuQRj7HgU&usqp=CAU"
  ];
  List Toys = [
    "https://cdn.fcglcdn.com/brainbees/images/marketing/d/toys_fest/banner-fisherprice.jpg",
    "https://images-eu.ssl-images-amazon.com/images/G/31/img16/Toys/Toybonanza-Sept16/1007185_RideScooter_ContentGrid_750x375._V279466089_.png",
    "https://images-eu.ssl-images-amazon.com/images/W/IMAGERENDERING_521856-T1/images/G/31/img16/Toys/AugART16/9_learntoys_440x300._V282096022_.jpg"
  ];
  List Fashion = [
    "https://www.baapoffers.com/uploads/amazon-upto-70-off-levis-lee-pepe-wrangler-clothings-offer-.jpg",
    "https://assetscdn1.paytm.com/images/catalog/view_item/787364/1617369686163.jpg?imwidth=480&impolicy=hq",
    "https://images-eu.ssl-images-amazon.com/images/W/IMAGERENDERING_521856-T1/images/G/31/img20/Beauty/PrimeDay20/COOP/Amazon-Prime-day-banner---750x375.jpg"
  ];
  List Hardwares = [
    "https://cdn2.vectorstock.com/i/1000x1000/45/56/poster-for-hardware-tools-vector-33274556.jpg",
    "https://hardwareshack.in/wp-content/uploads/2020/08/ezgif.com-resize-4.jpg",
    "https://edit.org/photos/editor/json/2023/01/04/a/a/aa416055370b32ec774658c9cc34c2c3_edit.org.jpg-376.jpg"
  ];
  List Footwear = [
    "https://assetscdn1.paytm.com/images/catalog/view_item/510728/1595596569487.png?imwidth=1600&impolicy=hq",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1616663022405/promo-code-for-shoes.jpg",
    "https://www.shopickr.com/wp-content/uploads/2016/06/puma-sale-footwear-sport-shoes-men-women-running-discount-70-percent-online.jpg"
  ];
  List Stationary = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVRHkfFixPa6zSExittuP-NCENPUMsZpxbH78jlqOnTn41WEjjiWD5PEwxVWVcZsOFSo&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQvErS9UPjDUFXp6Pi_0DZo4ZEpoEjRRlntZNsa_goqI3OL3vJAQOCvYDgA6WqiENEi44&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9ieVJI6q-FWhkpn-CFDN9gOEfkGpf45v_ZA&usqp=CAU"
  ];
  List Home1 = [
    "https://images.freeclues.com/assets/images/coupons/coupon_3407f3b13d664e0ce9bf9d5e72fb7d40.png",
    "https://1.bp.blogspot.com/-EXSBEUmo8BM/WsQcixT7u8I/AAAAAAABImI/mWdkzetTfqIQBQ1Ev3CsRJPeokyYB4UVgCLcBGAs/s1600/sm%2Bhome%2Bkitchenware%2Bsale%2Bapr-may%2B2018.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUukkjsuz7QeYzJGjBOc_WTyX5-CQM8lk9Pg&usqp=CAU"
  ];
  List Sports = [
    "https://images-eu.ssl-images-amazon.com/images/W/IMAGERENDERING_521856-T1/images/G/31/img21/Sports/Clearance21/Badminton.jpg",
    "https://admin.niviasports.com/uploadfile/offer_discount/Football.jpg",
    "https://s3media.247sports.com/Uploads/Assets/950/537/8537950.jpg"
  ];
  List Laptops = [
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1621489046640/hpshopping-discount-codes.jpg",
    "https://www.bajajmall.in/content/dam/emistoremarketplace/index/21-11-22/himalay/LapCLP_Row3_1_BigBanner_Desk_Laptops_PLP_B2B.jpg",
    "https://images.freekaamaal.com/post_images/1659529035.webp"
  ];
  List Auto = [
    "http://www.kompressor.co.ke/wp-content/uploads/Offers.jpg",
    "https://boodmo.com/media/images/slider/f0bb593.webp",
    "https://www.smartpartsexport.com/assets/img/mahindra-spare-parts.jpg"
  ];
  Widget _buildCategory(
      {required String name, required String photo, required List list}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryPage(category: name, slider: list, city: area)));
      },
      child: Card(
        child: SizedBox(
          height: 190,
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    image: DecorationImage(
                        image: AssetImage(
                          "images/$photo",
                        ),
                        fit: BoxFit.fill)),
              ),
              Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 230, 230),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 5,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 23,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        title: Text("Category",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            _buildCategory(
                photo: "electronics.jpg",
                name: "Electronics",
                list: Electronics),
            _buildCategory(photo: "phone.webp", name: "Mobiles", list: Mobiles),
            _buildCategory(
                photo: "dresses.jpg", name: "Fashion", list: Fashion),
            _buildCategory(
                photo: "Furniture.jpeg", name: "Furniture", list: Furniture),
            _buildCategory(photo: "toys.jpeg", name: "Toys", list: Toys),
            _buildCategory(
                photo: "hardware.jpg", name: "Hardwares", list: Hardwares),
            _buildCategory(
                photo: "shoes.webp", name: "Footwear", list: Footwear),
            _buildCategory(
                photo: "stationary.jpg", name: "Stationary", list: Stationary),
            _buildCategory(photo: "Utensils.webp", name: "Home", list: Home1),
            _buildCategory(photo: "sports.jpg", name: "Sports", list: Sports),
            _buildCategory(
                photo: "laptops.jpg", name: "Laptops", list: Laptops),
            _buildCategory(
                photo: "auto.jpg", name: "Auto spare Parts", list: Auto),
          ],
        ),
      ),
    );
  }
}
