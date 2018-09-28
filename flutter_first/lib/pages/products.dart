import 'package:flutter/material.dart';

import '../widgets/products/products.dart';

//here we used double dots to go back one folder and use the product manager class

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage(this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            //this attribute means that it
            // automatically tries to infer to what the first icon or action
            // in the app bar will be and we want to disable that feature so 'false'
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            //this argument is used to output some image which is put infront of the title
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: Products(products),
    );
  }
}
