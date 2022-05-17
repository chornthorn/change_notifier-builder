library change_notifier_builder;

import 'package:flutter/material.dart';

class ChangeNotifierBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierBuilder({
    Key? key,
    required this.changeNotifier,
    required this.builder,
    this.child,
  }) : super(key: key);

  final T changeNotifier;
  final ValueWidgetBuilder<T> builder;
  final Widget? child;

  @override
  ChangeNotifierBuilderState<T> createState() =>
      ChangeNotifierBuilderState<T>();
}

@protected
class ChangeNotifierBuilderState<T extends ChangeNotifier>
    extends State<ChangeNotifierBuilder<T>> {
  late T value;

  @override
  void initState() {
    value = widget.changeNotifier;
    widget.changeNotifier.addListener(_notifyListeners);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.changeNotifier != oldWidget.changeNotifier) {
      _updateUI(
        widget.changeNotifier,
        oldWidget.changeNotifier,
        _notifyListeners,
      );
    }
  }

  @override
  void dispose() {
    widget.changeNotifier.removeListener(_notifyListeners);
    super.dispose();
  }

  void _updateUI(
    Listenable newValue,
    Listenable oldValue,
    void Function() listener,
  ) {
    oldValue.removeListener(listener);
    value = widget.changeNotifier;
    newValue.addListener(listener);
  }

  void _notifyListeners() {
    setState(() {
      value = widget.changeNotifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
