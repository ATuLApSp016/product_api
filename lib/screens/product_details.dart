import 'package:flutter/material.dart';
import 'package:products_api/models/productData_model.dart';
import 'package:products_api/models/products_model.dart';

class ProductPage extends StatefulWidget {
  final ProductsModel mProductsData;

  ProductPage({super.key, required this.mProductsData});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mProductsData.title.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.images.toString(),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),*/
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.mProductsData.thumbnail.toString()),
                        fit: BoxFit.cover)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 21.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.mProductsData.title.toString(),
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Text(
                                    '\u{20B9}${widget.mProductsData.price.toString()}',
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black26,
                                      decoration: TextDecoration.lineThrough,
                                    )),
                                const SizedBox(width: 8),
                                Text(
                                    '\u{20B9}${widget.mProductsData.discountPercentage.toString()}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green.shade300,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 21),
                          child: Text(
                              widget.mProductsData.description.toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54)),
                        ),
                      ),
                      getContainer(
                          title: 'Brand',
                          value: widget.mProductsData.brand.toString()),
                      getContainer(
                          title: 'Category',
                          value: widget.mProductsData.category.toString()),
                      getContainer(
                          title: 'Stock',
                          value: widget.mProductsData.stock.toString()),
                      getContainer(
                          title: 'Rating',
                          value: widget.mProductsData.rating.toString()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getContainer({required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 11),
      padding: const EdgeInsets.all(21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87)),
          Text(value,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54)),
        ],
      ),
    );
  }
}
