import 'package:flutter/material.dart';

import '../widgets/helpers/ensure_visible.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  //the above key will hold a FormState because when we assign a key to that
  // Form widget, Flutter will actually give us back a reference to the internal
  // state of that Form.

  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        //here we want to bind th focus node to the
        // TextFormField to tell Flutter that we are not using it's default one,
        // otherwise we don't get notified when we tap in there
        decoration: InputDecoration(labelText: 'Product Title'),
        //autovalidate: true,//if this is set to true then the input will be validated automatically
        initialValue: widget.product == null ? '' : widget.product['title'],
        //it is used to set the initial value to the fields
        validator: (String value) {
          if (value.isEmpty || value.length < 5) {
            return 'Title is required and should be 5+ characters long.';
          }
          //if this function will not return anything then the validation succeeds
          // and if the function returns any string then the validation fails
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDecriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: InputDecoration(labelText: 'Product Description'),
        maxLines: 4,
        initialValue:
            widget.product == null ? '' : widget.product['description'],
        validator: (String value) {
          if (value.isEmpty || value.length < 10) {
            return 'Description is required and should be 10+ characters long.';
          }
          //if this function will not return anything then the validation succeeds
          // and if the function returns any string then the validation fails
        },
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Product Price'),
        keyboardType: TextInputType.number,
        focusNode: _priceFocusNode,
        initialValue:
            widget.product == null ? '' : widget.product['price'].toString(),
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Price is required and should be a number.';
          }
          //if this function will not return anything then the validation succeeds
          // and if the function returns any string then the validation fails
        },
        onSaved: (String value) {
          //we do not need the setState method here because we only want the value
          // and we do not want the rebuild the current state
          _formData['price'] = double.parse(value);
        },
      ),
    );
  }

  Widget _buildPageContent(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        //by doing this the keyboard will close if you click outside of the fields outside the Form.
      },
      child: Container(
        width: targetWidth,
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDecriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text('Save'),
                textColor: Colors.white,
                onPressed:
                _submitForm, //the method will be executed when we click that function.
              )
//          GestureDetector(
//            onTap: _submitForm,
//            child: Container(
//              color: Colors.green,
//              padding: EdgeInsets.all(5.0),
//              child: Text('My Button'),
//            ),
//          ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      //_formKey.currentState.validate();
      // above method will be used to call the validate method on all the fields of the Form object.
      return;
    }
    _formKey.currentState.save();
    //here currentState gives us access to the current form object.
    //whenever we call the save method on currentState then onSaved method in every TextFormField gets called

    if (widget.product == null) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {


    final Widget pageContent = _buildPageContent(context);
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
