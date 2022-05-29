import 'package:colorize/colorize.dart';

class Utils{

  static printRedBGWhite(String text){
    var colorize = Colorize(text);
    print(colorize.red().bgWhite());
  }

  static printBlackBGYellow(String text){
    var colorize = Colorize(text);
    print(colorize.bgYellow().white());
  }
}