import 'dart:html';

import 'package:flutter/material.dart';
import 'image_banner.dart';
import 'text_section.dart';




class CompanyDetail extends StatelessWidget {
  final int _company;
  final String _imagePath;
  final String _name;
  final String _description;
  final IconData _iconSymbol;
  final Color _iconColor;

  CompanyDetail(this._company, this._imagePath, this._name, this._description,  this._iconSymbol, this._iconColor);


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children: [
            ImageBanner(getCompanyImage(_company, _imagePath)),
            TextSection(getCompanyName(_company, _name), getCompanyDetail(_company, _description), getIconSymbol(_company, _iconSymbol), getIconColor(_company, _iconColor)),
          ],
        ));
  }

  getCompanyImage(company, imagePath){
    if (company==0){
      imagePath = "assets/images/1_bad-company-logo_scaled.jpg";
    } else {
      imagePath = "assets/images/2_good-company-logo_scaled.jpg";
    }
  }

  getCompanyName(company, name){
    if(company==0){
      name = "RVVE";
    } else {
      name = "Natüre";
    }
    return name;
  }

  getCompanyDetail(company, description){
    if(company==0){
      description = "You caught this company doing greenwashing... what a shame";
    } else {
      description = "What a great sustainable company";
    }
    return description;
  }

  getIconSymbol(company, symbol){
    if(company==0){
      symbol = Icons.remove_circle;
    } else {
      symbol = Icons.add;
    }
    return symbol;
  }

  getIconColor(company, color){
    if(company==0){
      color = Colors.black;
    } else {
      color = Colors.lightGreen;
    }
    return color;
  }

}

