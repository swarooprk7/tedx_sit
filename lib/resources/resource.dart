import 'package:tedx_sit/resources/color.dart';
import 'package:tedx_sit/resources/image.dart';
import 'package:tedx_sit/resources/navigation.dart';
import 'package:tedx_sit/resources/string.dart';

abstract class Resource {
  static MyColor color = MyColor();
  static MyString string = MyString();
  static MyImage image = MyImage();
  static MyNavigation navigation = MyNavigation();
}
