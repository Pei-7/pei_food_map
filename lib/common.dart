import 'package:flutter/material.dart';

class ScreenSize {
  final double standardLength;

  const ScreenSize({required this.standardLength});

  static Size getStandardSize(BuildContext context) {
    //在其他 widgets 中就可以用 ScreenSize.getStandardWidth(context) 來直接獲取適宜的寬度比例啦。
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = height / 850 * 400; //iphone15: 852:393
    Size fixedSize = Size(width, height);
    return fixedSize;
  }
}
