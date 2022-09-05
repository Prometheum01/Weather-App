import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double lowPaddingValue() => getDynamicHeight(0.01);
  double mediumPaddingValue() => getDynamicHeight(0.02);
  double highPaddingValue() => getDynamicHeight(0.03);

  Duration lowDuration() => const Duration(milliseconds: 250);
  Duration mediumDuration() => const Duration(milliseconds: 500);
  Duration highDuration() => const Duration(milliseconds: 1000);

  double getDynamicHeight(double value) =>
      MediaQuery.of(this).size.height * value;
  double getDynamicWidth(double value) =>
      MediaQuery.of(this).size.width * value;

  BorderRadius smallBorderRadius() =>
      const BorderRadius.all(Radius.circular(12));
  BorderRadius mediumBorderRadius() =>
      const BorderRadius.all(Radius.circular(18));
}
