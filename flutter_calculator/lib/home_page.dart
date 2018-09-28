import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var num1 = 0, num2 = 0, sum = 0;

  final TextEditingController t1 = new TextEditingController(text: "0");
  final TextEditingController t2 = new TextEditingController(text: "0");

  void doAddititon() {
    setState(() {
      sum = num1 + num2;
    });
  }

  void doSubtraction() {
    setState(() {
      sum = num1 - num2;
    });
  }

  void doMultiplication() {
    setState(() {
      sum = num1 * num2;
    });
  }

  void doDivision() {
    setState(() {
      sum = num1 ~/ num2;
    });
  }

  void doClear(){
    setState(() {
      num1 = 0;
      num2 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Output : $sum',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter number 1",
              ),
              onChanged: (String value) {
                num1 = int.parse(value);
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter number 2",
              ),
              onChanged: (String value) {
                num2 = int.parse(value);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text('+'),
                  color: Colors.greenAccent,
                  onPressed: doAddititon,
                ),
                MaterialButton(
                  child: Text('-'),
                  color: Colors.greenAccent,
                  onPressed: doSubtraction,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text('*'),
                  color: Colors.greenAccent,
                  onPressed: doMultiplication,
                ),
                MaterialButton(
                  child: Text('/'),
                  color: Colors.greenAccent,
                  onPressed: doDivision,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: new Text("Clear"),
                  color: Colors.greenAccent,
                  onPressed: doClear,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
