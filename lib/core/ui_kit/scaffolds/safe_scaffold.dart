import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

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
    return Scaffold(
      backgroundColor: backgroundColor ?? context.colors.backPrimary,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: padding,
          child: body,
        ),
      ),
    );
  }
}
