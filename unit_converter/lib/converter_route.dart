import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

///[ConverterRoute] where users can input amounts to convert in one [Unit] and
/// retrieve the conversion in another [Unit] for a specific [Category]
class ConverterRoute extends StatefulWidget {

  ///This [Category]'s name.
  final String name;

  ///Color for this [Category]
  final Color color;

  ///Units for this [Category]
  final List<Unit> units;

  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units,
  })
      : assert(name != null),
        assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue='';
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidateError = false;

  @override
  void initState(){
    super.initState();
    _createDropDownMenuItems();
    _setDefaults();
  }

  ///Creates fresh list of [DropdownMenuItem] widgets, given a list of [Unit]s.
  void _createDropDownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }

    setState(() {
      _unitMenuItems = newItems;
    });
  }

  ///Sets the default values for the 'from' and 'to' [Dropdown]s.
  void _setDefaults(){
    setState(() {
      _fromValue = widget.units[0];
      _toValue = widget.units[1];
    });
  }

  String _format(double conversion){
    var outputNum = conversion.toStringAsPrecision(7);
    if(outputNum.contains('.') && outputNum.endsWith('0')){
      var i = outputNum.length-1;
      while(outputNum[i]==0){
        i-=1;
      }
      outputNum.substring(0,i+1);
    }
    if(outputNum.endsWith('.')){
      return outputNum.substring(0,outputNum.length-1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    //TODO
    //TODO
    //TODO
    //TODO
    //TODO


    final unitWidgets = widget.units.map((Unit unit){

      return Container(
        color: widget.color,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subhead,
            ),
          ],
        ),
      );
    }).toList();

    return ListView(
      children: unitWidgets,
    );
  }

}