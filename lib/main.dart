import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/app_startup.dart';
import 'package:flutter_ship_app/src/data/shared_preferences.dart';
import 'package:flutter_ship_app/src/presentation/apps_list_screen.dart';
import 'package:flutter_ship_app/src/utils/app_theme_data.dart';
import 'package:flutter_ship_app/src/utils/app_theme_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // needed to read the theme mode before calling runApp
  await container.read(sharedPreferencesProvider.future);
  // run app
  runApp(UncontrolledProviderScope(
    container: container,
    child: AppStartupWidget(
      onLoaded: (context) => const MainApp(),
    ),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light(),
      darkTheme: AppThemeData.dark(),
      themeMode: themeMode,
      home: const AppsListScreen(),
      // * Uncomment this line to perform accessibility checks
      // builder: (context, child) => AccessibilityTools(child: child),
    );
  }
}
