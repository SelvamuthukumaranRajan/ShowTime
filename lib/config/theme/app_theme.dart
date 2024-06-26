import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AppTheme {
  ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.primaryLight.fromHex,
      // useMaterial3: true,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  //TODO: Update new theme for Dark mode(Currently its a light duplicate)
  // ThemeData buildDarkTheme() {
  //   final ThemeData base = ThemeData.dark();
  //   return base.copyWith(
  //     visualDensity: VisualDensity.adaptivePlatformDensity,
  //     primaryColor: AppColors.primaryDark.fromHex,
  //     // useMaterial3: true,
  //     iconTheme: const IconThemeData(
  //       color: Colors.white,
  //     ),
  //     appBarTheme: const AppBarTheme(
  //       titleTextStyle: TextStyle(
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
  ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.primaryLight.fromHex,
      // useMaterial3: true,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

extension HexColorExt on String {
  Color get fromHex {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) {
      buffer.write('ff');
    }
    if (startsWith('#')) {
      buffer.write(replaceFirst('#', ''));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension CustomText on TextTheme {
  //AppBAr Styles
  TextStyle get appBarLocationBoldStyle => const TextStyle(
        fontFamily: 'Quicksand',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      );
  TextStyle get appBarLocationStyle => const TextStyle(
        fontFamily: 'Quicksand',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );
  TextStyle get searchBarStyle => const TextStyle(
        fontFamily: 'Quicksand',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w200,
        fontSize: 16,
      );

  //MovieCountCard Style
  TextStyle get movieCountDateStyle => const TextStyle(
        fontFamily: 'Quicksand',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
  TextStyle get movieCountBoldStyle => const TextStyle(
        fontFamily: 'Quicksand',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  TextStyle get movieCountStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  //Landing Screen
  TextStyle get landingTitleStyle => const TextStyle(
        fontFamily: 'Quicksand',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );

  //NowPlayingMovie Card Style
  TextStyle get nowPlayingTitleStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
  TextStyle get nowPlayingDescStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  TextStyle get nowPlayingVoteStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  TextStyle get nowPlayingLanguageStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  //TopRatedScreen
  TextStyle get topRatedTitleStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  TextStyle get topRatedDescStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  TextStyle get topRatedTextStyle => const TextStyle(
    fontFamily: 'Quicksand',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
    fontSize: 16,
  );
}

extension CustomColorScheme on ColorScheme {
  Color get primaryColor => AppColors.primary.fromHex;

  Color get secondaryColor => AppColors.secondary.fromHex;

  Color get lightBGColor => AppColors.bgColorLight.fromHex;

  String themeBrightness() {
    var mode = 'light';
    if (brightness == Brightness.dark) {
      mode = 'dark';
    }
    return mode;
  }

  Color get opacity2 =>
      Color(int.parse("0x80${AppColors.bgColorLight.replaceAll('#', '')}"));

  Color get opacity3 =>
      Color(int.parse("0xcc${AppColors.bgColorDark.replaceAll('#', '')}"));

  Color get opacity4 =>
      Color(int.parse("0xcc${AppColors.bgColorDark.replaceAll('#', '')}"));

  Color bgColor() {
    Color bgColor = AppColors.bgColorLight.fromHex;
    // var brightness = SchedulerBinding.instance!.window.platformBrightness;
    if (brightness == Brightness.dark) {
      bgColor =
          // Color(0xFF191927);
          Color(int.parse("0xff${AppColors.bgColorDark.replaceAll('#', '')}"));
    }
    return bgColor;
  }

  Color colorWithOpt(int opacity, String hex, String darkHex) {
    String optStr;
    switch (opacity) {
      case 1:
        optStr = '0x1A';
        break;
      case 2:
        optStr = '0x33';
        break;
      case 3:
        optStr = '0x4D';
        break;
      case 4:
        optStr = '0x66';
        break;
      case 5:
        optStr = '0x80';
        break;
      case 6:
        optStr = '0x99';
        break;
      case 7:
        optStr = '0xB3';
        break;
      case 8:
        optStr = '0xCC';
        break;
      case 9:
        optStr = '0xE6';
        break;
      case 10:
        optStr = '0xff';
        break;
      default:
        optStr = '0xff';
    }
    String temp = hex.replaceAll('#', '');
    Color newColor = Color(int.parse("$optStr$temp"));
    if (brightness == Brightness.dark) {
      String temp2 = darkHex.replaceAll('#', '');
      newColor = Color(int.parse("$optStr$temp2"));
    }
    return newColor;
  }

  Color textColor() {
    Color bgColor = AppColors.textColorDark.fromHex;
    if (brightness == Brightness.dark) {
      bgColor = Colors.white;
    }
    return bgColor;
  }

  Color buttonColorOpposite() {
    Color bgColor = Colors.white;
    if (brightness == Brightness.dark) {
      bgColor = AppColors.textColorDark.fromHex;
    }
    return bgColor;
  }
}
