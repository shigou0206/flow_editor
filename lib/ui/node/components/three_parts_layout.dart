import 'package:flutter/material.dart';

class ThreePartsLayout extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;

  final double headerHeight;
  final double footerHeight;

  const ThreePartsLayout({
    super.key,
    this.header,
    required this.body,
    this.footer,
    this.headerHeight = 40.0,
    this.footerHeight = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null)
          SizedBox(
            height: headerHeight,
            child: header,
          ),
        Expanded(
          child: body,
        ),
        if (footer != null)
          SizedBox(
            height: footerHeight,
            child: footer,
          ),
      ],
    );
  }
}
