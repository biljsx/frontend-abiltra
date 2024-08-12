import 'package:flutter/material.dart';
import 'package:flutter_todoapp/config/routes/routes.dart';
import 'package:flutter_todoapp/screens/home_screen.dart';
import 'package:flutter_todoapp/screens/screens.dart';
import 'package:go_router/go_router.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];
