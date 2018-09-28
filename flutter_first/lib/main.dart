import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';

void main() {
  //debugPaintSizeEnabled = true; //this line is used to debug the UI elements i.e.
  // to see how the things are laid out as they are laid out
  //debugPaintBaselinesEnabled=true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp()); //runApp() has to be called inside the main function and the
  // constructor of the below class should be passed
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

//We want to create a widget and a widget will be an object which is why we
// create a class to define how an object should look like
//this class extends StatelessWiget so we can use the class to draw as Widget
// on the screen
class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      //the setState method is called to re render the state whenever there is a change
      _products.add(product);
    });
  }

  void _updateProduct(int index,Map<String,dynamic> product){
    setState(() {
      _products[index] = product;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
        buttonColor: Colors.deepPurple,
      ),
      //home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) =>
            ProductsAdminPage(_addProduct,_updateProduct, _deleteProduct,_products),
      },
      onGenerateRoute: (RouteSettings settings) {
        //the above settings variable actually holds the name that we want to navigate to
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
          //the first element after splitting of the settings variable will always
          // be ''. if it is not then we are having an error and in that case we return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                  _products[index]['title'],
                  _products[index]['image'],
                  _products[index]['price'],
                  _products[index]['description'],
                ),
          );
        }
        return null;
        //here we return here if we get some invalid code.
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductsPage(_products));
      },
    ); //by returning the MaterialApp() here, we are calling
    // the constructor of the class MaterialApp and it's object is being returned here.
  }
}
