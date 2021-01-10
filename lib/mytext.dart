import 'package:flutter/material.dart';

///This is a custom Text which is used by home screen
///All the text which is shown in the app is displayed using this class
class MyText extends StatelessWidget{

  String text;
  double size;
  Color color;
  FontWeight fontWeight;
  TextPadding textPadding;
  Color backgroundColor = Colors.white;

  MyText(String text, double size, Color color, FontWeight fontWeight,
      TextPadding textPadding, [Color backgroundColor]){
    this.text = text;
    this.size = size;
    this.color = color;
    this.fontWeight = fontWeight;
    this.textPadding = textPadding;
    this.backgroundColor = backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.fromLTRB(textPadding.left, textPadding.top,
            textPadding.right, textPadding.bottom),
        child: Text(text,
            style: TextStyle(fontSize: size, backgroundColor: backgroundColor,
                color: color,fontWeight: fontWeight)));
  }

}

class TextPadding{
  double left = 0;
  double right = 0;
  double top = 0;
  double bottom = 0;

  TextPadding(this.left, this.top,this.right,this.bottom);

  double get leftP => left;
  double get topP => top;
  double get rightP => right;
  double get bottomP => bottom;
}