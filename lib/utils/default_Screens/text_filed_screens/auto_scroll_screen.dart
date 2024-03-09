import 'package:flutter/material.dart';

class AutoScrollTextFieldScreen extends StatefulWidget {
  final Widget child;
  const AutoScrollTextFieldScreen({required this.child,super.key});

  @override
  State<AutoScrollTextFieldScreen> createState() => _AutoScrollTextFieldScreenState();
}

class _AutoScrollTextFieldScreenState extends State<AutoScrollTextFieldScreen> with WidgetsBindingObserver{

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!MediaQuery.of(context).viewInsets.bottom.isNaN && MediaQuery.of(context).viewInsets.bottom == 0) {
      // Keyboard is hidden
      _resetScrollPosition();
    }
  }

  void _resetScrollPosition() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: widget.child,
    );
  }
}
