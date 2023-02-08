import "package:flutter/material.dart";

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  Widget _buildCategory({required String name, required String photo}) {
    return Card(
      child: Container(
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: Text(
            "Category",
          )),
      body: GridView(
        children: [
          _buildCategory(photo: "electronics.jpg", name: "Electronics"),
          _buildCategory(photo: "phone.webp", name: "Mobiles"),
          _buildCategory(photo: "dresses.jpg", name: "Fashion"),
          _buildCategory(photo: "Furniture.jpeg", name: "Furniture"),
          _buildCategory(photo: "toys.jpeg", name: "Toys"),
          _buildCategory(photo: "Grocery.png", name: "Grocery"),
          _buildCategory(photo: "shoes.webp", name: "Footwear"),
          _buildCategory(photo: "stationary.jpg", name: "Stationary"),
          _buildCategory(photo: "Utensils.webp", name: "Home"),
          _buildCategory(photo: "sports.jpg", name: "Sports"),
        ],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
