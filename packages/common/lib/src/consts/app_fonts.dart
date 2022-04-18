import 'package:common/src/consts/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension TextExtension on Text {
  Text headline1({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      fontSize: 46.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text headline2({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      fontSize: 36.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text headline3({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 24.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text headline4({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral400,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text subtitle1({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      height: 1.6,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text subtitle2({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text subtitle3({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text body1({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text body2({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      height: 1.4,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text body3({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontSize: 12.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text button({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      fontSize: 14.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }

  Text overline({TextStyle? style}) {
    final defaultStyle = TextStyle(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w400,
      fontSize: 10.0,
      fontStyle: FontStyle.normal,
      color: ColorPalette.neutral600,
    );
    return Text(data!,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: (this.style ?? defaultStyle).merge(style ?? defaultStyle));
  }
}
