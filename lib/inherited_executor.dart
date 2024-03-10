import 'package:flutter/material.dart';

class InheritedExecutor extends StatelessWidget {
  final Function switchTheme;
  final Function switchLocale;
  final Widget child;

  const InheritedExecutor({
    super.key,
    required this.switchTheme,
    required this.switchLocale,
    required this.child,
  });

  static InheritedExecutor of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<InheritedExecutor>()!;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
