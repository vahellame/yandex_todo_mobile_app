import 'package:flutter/material.dart';

class SafeScaffold extends StatelessWidget {
  const SafeScaffold({
    this.body,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.backgroundColor,
    this.floatingActionButton,
    super.key,
  });

  final Widget? body;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        backgroundColor: backgroundColor,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: padding,
            child: body,
          ),
        ),
      ),
    );
  }
}
