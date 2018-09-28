import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  ProductPage(this.title, this.imageUrl, this.price, this.description);

  Widget _buildAddressPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Union Square, San Francisco',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  /*
  _showWarningDialog(BuildContext context){
    showDialog(context : context,builder: (BuildContext context) {
      return AlertDialog(title: Text('Are you sure?'),
        content: Text('This action cannot be undone!'),
        actions: <Widget>[
          FlatButton(
            child: Text('DISCARD'),
            onPressed: () {
              Navigator.pop(
                  context); //this will just close the dialog not the page
            },
          ),
          FlatButton(child: Text('CONTINUE'), onPressed: () {
            Navigator.pop(context);
            //you can pass back information here and showDialog will receive the information using the then block code
            Navigator.pop(context,true);
            //the first Navigator closes the dialog and the second one navigates away with true value.
            //the 2nd Navigator will delete the product and navigate away from the page
          },)
        ],
      );
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back Button Pressed');
        Navigator.pop(context, false);
        return Future.value(false); //if you pass here true then you can leave
        //if you pass in true then another pop operation begins and then the app will crash
        //if you pass false there then it will not work without Navigator.pop operation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(title),
            ),
            _buildAddressPriceRow(),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
