import 'package:flutter/material.dart';

import './product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products); //the parameter here in dart will take the incoming
  // argument and store it in a property with the same name

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        //here we assign a reference to a method
        // which defines how a product is build. Without paranthesis means that it
        // will not be executed now. but will be executed when the item is needed
        itemCount: products.length,
      );
    } else {
      //when you do not want to render anything when the list is empty then to
      // you have to render the productCard as an empty Container(). The empty container will not take any space

      productCards = Center(
        child: Text('No products found, please add some'),
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    //the build method cannot return null. it has to return a widget

//    return products.length > 0
//        ? ListView.builder(
//            itemBuilder:
//                _buildProductItem, //here we assign a reference to a method
//            // which defines how a product is build. Without paranthesis means that it
//            // will not be executed now. but will be executed when the item is needed
//            itemCount: products.length,
//          )
//        : Center(
//            child: Text('No products found, please add some'),
//          );
    return _buildProductList();
  }
}
