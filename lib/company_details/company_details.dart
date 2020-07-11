import 'package:flutter/material.dart';
import 'image_banner.dart';
import 'text_section.dart';

class CompanyDetail extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children: [
            ImageBanner("assets/images/1_bad-company-logo_scaled.jpg"),
            TextSection("header","body"),
          ],
        ));
  }
}
