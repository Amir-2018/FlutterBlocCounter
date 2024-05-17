import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String imageUrl;
  const ProductDetailsPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        /*actions: const [
          Container(),
        ],*/
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Add to Cart'),
        icon: const Icon(Icons.shopping_cart),
      ),
      body: ListView(
        children: [
          // Product image
          Image.asset(
            imageUrl,
            height: MediaQuery.of(context).size.height / 1.8,
            fit: BoxFit.fill,
          ),

          // Product title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(
              'Digital Print Poly Cotton Goa Style Tropical Wear Mens Shirt, Half Sleeves, Magic Cotton',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),

          // Product description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget risus lacus. Curabitur a turpis eros. Cras congue dui nec magna aliquet, quis vehicula libero egestas. Nullam at sollicitudin sem. Sed a augue dictum, tempor mi quis, feugiat neque. Aliquam egestas lectus orci, et rhoncus augue suscipit quis. Ut quis porta magna.'),
          ),

          // Product price
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '\$100',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}