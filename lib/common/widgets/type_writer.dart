import 'dart:async';

import 'package:flutter/material.dart';

class TypewriterWithScroll extends StatefulWidget {
  final String text;
  final Duration charDuration;
  final ScrollController scrollController;
  final VoidCallback? onComplete;
  final TextStyle? style;

  const TypewriterWithScroll({
    Key? key,
    required this.text,
    required this.scrollController,
    this.charDuration = const Duration(milliseconds: 50),
    this.onComplete,
    this.style,
  }) : super(key: key);

  @override
  _TypewriterWithScrollState createState() => _TypewriterWithScrollState();
}

class _TypewriterWithScrollState extends State<TypewriterWithScroll> {
  String _displayText = '';
  late int _currentIndex;
  Timer? _timer;
  bool _isCompleted = false; // 记录动画是否已完成

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _startTyping();
  }

  void _startTyping() {
    _isCompleted = false;
    _timer = Timer.periodic(widget.charDuration, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _currentIndex++;
          _displayText = widget.text.substring(0, _currentIndex);
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.scrollController.hasClients) {
            widget.scrollController.animateTo(
              widget.scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeOut,
            );
          }
        });
      } else {
        _completeTyping();
      }
    });
  }

  void _completeTyping() {
    _timer?.cancel();
    if (!_isCompleted) {
      setState(() {
        _displayText = widget.text;
        _isCompleted = true;
      });

      if (widget.onComplete != null) {
        widget.onComplete!();
      }
    }
  }

  void _onTap() {
    if (!_isCompleted) {
      _completeTyping();
    }
  }

  @override
  void didUpdateWidget(covariant TypewriterWithScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _timer?.cancel();
      _currentIndex = 0;
      _displayText = '';
      _startTyping();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Text(_displayText, style: widget.style),
    );
  }
}
