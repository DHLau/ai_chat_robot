import 'dart:ui';

class ColorHelper {
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff'); // 添加不透明度
    }
    hexString = hexString.replaceFirst('#', '');
    buffer.write(hexString);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
