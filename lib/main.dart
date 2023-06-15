import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/l10n/generated/l10n.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/logger.dart';
import 'features/domain/controllers/todo/create_or_todo_controller.dart';
import 'features/domain/controllers/todo/todos_controller.dart';
import 'features/pages/todos/todos_page.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (d) => Logger.e(d.exception, d.stack);

      PlatformDispatcher.instance.onError = (error, stack) {
        Logger.e(error, stack);
        return true;
      };

      DependencyInjection.inject();

      runApp(
        MultiProvider(
          providers: [
            ListenableProvider(create: (_) => TodosController(GetIt.I.get())),
            ListenableProvider(create: (_) => CreateOrUpdateTodoController(GetIt.I.get())),
          ],
          child: const TodoApp(),
        ),
      );
    },
    (e, s) {
      Logger.e(e, s);
    },
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TodosPage(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.delegate.supportedLocales,
      locale: const Locale('ru'),
    );
  }
}
