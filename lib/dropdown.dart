import 'package:flutter/material.dart';
import 'dart:developer';

import 'book_ticket_model.dart';

///This is a custom drop-down widget which is displayed in our app
class RoundedBorderDropdown extends StatefulWidget {
  //RoundedBorderDropdown({Key key}) : super(key: key);
  List<String> list;
  String label;
  MyModel model;
  //RoundedBorderDropdown({this.list, this.label});
  RoundedBorderDropdown(List<String> _dropdownValues, String label, MyModel model){
    list = _dropdownValues;
    this.label = label;
    this.model = model;
  }

  @override
  _RoundedBorderDropdown createState() => _RoundedBorderDropdown(list, label, model);
}

class _RoundedBorderDropdown extends State<RoundedBorderDropdown> {

  List<String> _dropdownValues;
  String label;
  MyModel model;
  _RoundedBorderDropdown(List<String> _dropdownValues, String label, MyModel model){
    this._dropdownValues = _dropdownValues;
    this.label = label;
    this.model = model;
  }

  String _selectedItem = '';

  @override
  void initState() {
    _selectedItem = _dropdownValues.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
        width: w / 2,
        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blueGrey,
          border: Border.all(
              color: Colors.white, style: BorderStyle.solid, width: 0.80),
        ),
        child: Container(
            child: Column(
              children: <Widget>[


                new DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _selectedItem,
                      //    isDense: true,
                      //hint: Text('DropdownButton Hint'),
                      iconEnabledColor: Colors.black,
                      onChanged: (String value) {
                        model.prepareShow(value);
                        //model.onShowChange(value);

                        setState(() {
                          _selectedItem = value;
                          log('Combooooo: $_selectedItem');
                        });
                      },

                      items: _dropdownValues
                          .map((value) => DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      ))
                          .toList(),

                      isExpanded: true,
                    ))
                //),
              ],
            ))

      //)

    );
    // );
  }
}
