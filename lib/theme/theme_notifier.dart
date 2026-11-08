import 'package:flutter/material.dart';

import '../../data/datasources/local_database_service.dart';

class ThemeNotifier extends ChangeNotifier {
  final DatabaseService _databaseService;

  Color _backgroundColor = const Color(0xFFF5F8FD);

  ThemeNotifier(this._databaseService);

  Color get backgroundColor => _backgroundColor;

  ThemeData get themeData {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _backgroundColor,
      brightness: Brightness.light,
    );

    return ThemeData.from(
      colorScheme: colorScheme,
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: _backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: _backgroundColor.withOpacity(0.92),
        foregroundColor: _backgroundColor.computeLuminance() > 0.5
            ? Colors.black87
            : Colors.white,
        elevation: 0,
      ),
      cardColor: Colors.white,
      dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
      colorScheme: colorScheme,
    );
  }

  Color get scaffoldBackgroundColor => _backgroundColor;

  Color get appBarBackgroundColor =>
      themeData.appBarTheme.backgroundColor ??
      _backgroundColor.withOpacity(0.92);

  Color get appBarForegroundColor =>
      themeData.appBarTheme.foregroundColor ??
      (_backgroundColor.computeLuminance() > 0.5
          ? Colors.black87
          : Colors.white);

  Future<void> loadTheme() async {
    final savedColor = await _databaseService.getSetting(
      'theme_background_color',
    );
    if (savedColor != null) {
      _backgroundColor = _fromHex(savedColor);
    }
    notifyListeners();
  }

  Future<void> updateBackgroundColor(Color color) async {
    _backgroundColor = color;
    notifyListeners();
    await _databaseService.saveSetting('theme_background_color', _toHex(color));
  }

  String _toHex(Color color) =>
      color.value.toRadixString(16).padLeft(8, '0');

  Color _fromHex(String hex) {
    try {
      var normalized = hex.replaceFirst('#', '');
      if (normalized.length == 6) {
        // add opaque alpha if missing
        normalized = 'ff$normalized';
      }
      return Color(int.parse(normalized, radix: 16));
    } catch (e) {
      debugPrint('⚠️ Erreur lors du parsing hex: $hex - $e');
      return const Color(0xFFF5F8FD); // Retour à la couleur par défaut
    }
  }
}
