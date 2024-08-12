import 'package:flutter/material.dart';
import 'package:flutter_todoapp/config/config.dart';
import 'package:flutter_todoapp/config/theme/app_theme.dart';
import 'package:flutter_todoapp/config/theme/theme.dart';
// import 'package:flutter_todoapp/screens/screens.dart';
import 'package:flutter_todoapp/config/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routeConfig,
    );
  }
}
