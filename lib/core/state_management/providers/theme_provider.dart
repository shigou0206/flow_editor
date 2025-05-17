import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flow_editor/core/models/enums.dart';

// ───────── StateNotifier ─────────
class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme.light) {
    _loadFromPrefs(); // 启动时加载缓存
  }

  // 切换到指定主题
  void setTheme(AppTheme theme) {
    if (state == theme) return;
    state = theme;
    _saveToPrefs(theme);
  }

  // 在 light / dark 之间切换；其它主题保持不变
  void toggle() {
    final newTheme = switch (state) {
      AppTheme.dark => AppTheme.light,
      AppTheme.light => AppTheme.dark,
      _ => state, // ocean/sepia 不动
    };
    setTheme(newTheme);
  }

  // ── 本地持久化（可选） ──
  static const _kKey = 'app_theme';

  Future<void> _saveToPrefs(AppTheme t) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kKey, t.index);
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final idx = prefs.getInt(_kKey);
    if (idx != null && idx < AppTheme.values.length) {
      state = AppTheme.values[idx];
    }
  }
}

// ───────── Provider ─────────
final themeProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());
