import 'package:flutter/material.dart';

class AppBottomsheet {
  static Future<void> display(BuildContext context, Widget widget) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => widget,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
    );
  }
}
