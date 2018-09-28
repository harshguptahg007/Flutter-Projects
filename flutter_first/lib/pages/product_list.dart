import 'package:flutter/material.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct,this.deleteProduct);

  Widget _buildEditButton(BuildContext context,int index){
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductEditPage(
                  product: products[index],
                  updateProduct: updateProduct,
                  productIndex: index,
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index]['title']),//it is not like the key that we used on the Form, but a key that updates this list efficiently.
          //because once we remove a item, flutter should be able to track that it should not display that anymore
          background: Container(color: Colors.red,),
          onDismissed: (DismissDirection direction){
            if(direction == DismissDirection.endToStart){
              deleteProduct(index);
            }
          },
          child: Column(
          children: <Widget>[
            ListTile(
              leading: new CircleAvatar(
                backgroundImage: AssetImage(products[index]['image']),
              ),
              title: Text(
                products[index]['title'],
              ),
              subtitle: Text('\$${products[index]['price'].toString()}'),
              trailing: _buildEditButton(context, index),
            ),
            Divider(),
          ],
        ),);
      },
      itemCount: products.length,
    );
  }
}
