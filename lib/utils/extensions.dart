import 'package:flutter/material.dart';

extension WidgetX on Widget {
  Widget get withFullWidth => SizedBox(width: double.infinity, child: this);
  Widget get withMarginH8 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: this);
}
