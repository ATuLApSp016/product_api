import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:products_api/models/productData_model.dart';
import 'package:products_api/screens/product_details.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<ProductDataModel?> _buildProductsData() async {
    ProductDataModel? mProductsData;
    String productUrl = 'https://dummyjson.com/products';

    var response = await http.get(Uri.parse(productUrl));

    if (response.statusCode == 200) {
      var mData = response.body;

      var productData = jsonDecode(mData);
      print(productData);

      mProductsData = ProductDataModel.fromJson(productData);
    }
    return mProductsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
      ),
      body: FutureBuilder(
        future: _buildProductsData(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.hasError}'));
          } else if (snap.hasData) {
            return snap.data != null
                ? snap.data!.products!.isNotEmpty
                    ? ListView.builder(
                        itemCount: snap.data!.products!.length,
                        itemBuilder: (_, childIndex) {
                          var eachProducts = snap.data!.products![childIndex];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                                title: eachProducts.title!,
                                                desc: eachProducts.description!,
                                                price: eachProducts.price!,
                                                discountPercentage: eachProducts
                                                    .discountPercentage!,
                                                rating: eachProducts.rating!,
                                                stock: eachProducts.stock!,
                                                brand: eachProducts.brand!,
                                                category:
                                                    eachProducts.category!,
                                            thumbnail: eachProducts.thumbnail!,
                                              )));
                                },
                                leading: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              eachProducts.thumbnail!),
                                          fit: BoxFit.cover)),
                                ),
                                title: Text(eachProducts.title!),
                                subtitle: Text(eachProducts.description!),
                              ),
                            ),
                          );
                        })
                    : const Center(child: Text('No products found!!'))
                : const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }

  getContainer({required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87)),
          Text(value,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
        ],
      ),
    );
  }
}
