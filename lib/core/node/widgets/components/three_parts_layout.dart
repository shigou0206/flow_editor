import 'package:flutter/material.dart';

class ThreePartsLayout extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? footer;

  const ThreePartsLayout({
    super.key,
    this.header,
    this.body,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) header!,
        if (body != null) body!,
        if (footer != null) footer!,
      ],
    );
  }
}
