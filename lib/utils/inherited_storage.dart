import 'package:flutter/material.dart';

/// Inherited storage that can access to ancestor's storage
class InheritedStorage extends StatelessWidget {
  final Map _map;
  final InheritedStorage? _ancestor;
  final Widget child;

  void put(key, value) {
    _map[key] = value;
  }

  dynamic get(key) {
    return _map[key] ?? _ancestor?.get(key);
  }

  operator [](key) => get(key); // get
  operator []=(key, value) => put(key, value); // put

  InheritedStorage({
    super.key,
    required context,
    required this.child,
    map,
  })  : _ancestor = context.findAncestorWidgetOfExactType<InheritedStorage>(),
        _map = map ?? {};

  static InheritedStorage of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<InheritedStorage>()!;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
