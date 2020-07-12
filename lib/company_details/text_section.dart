import 'package:flutter/material.dart';


class TextSection extends StatelessWidget {
  final String _title;
  final String _body;
  final IconData _iconSymbol;
  final Color _iconColor;
  static const double _hPad=16.0;

  TextSection(this._title, this._body, this._iconSymbol, this._iconColor);
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad,32.0,_hPad,4.0),
        child: Text(_title, style: Theme.of(context).textTheme.title),),
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad,10.0,_hPad,_hPad),
            child: new Icon(_iconSymbol, color: _iconColor, size:50),),
        Container(
          padding: const EdgeInsets.fromLTRB(_hPad,10.0,_hPad,_hPad),
        child: Text(_body,style: Theme.of(context).textTheme.body1),)
        ],
    );
    
  }
  getIcon(_company,_icon){
    if (_company== 0){
      _icon = new Icon(Icons.remove_circle, color: Colors.black, size: 50);
    }else {
      _icon = new Icon(Icons.add, color: Colors.lightGreen, size: 50);
    }

    return _icon;
  }
}