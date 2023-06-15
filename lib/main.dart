import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/l10n/generated/l10n.dart';
import 'core/theme/app_theme.dart';
import 'features/domain/controllers/task/create_task_controller.dart';
import 'features/domain/controllers/task/tasks_controller.dart';
import 'features/pages/todos/todos_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjection.inject();

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(create: (_) => TodosController(GetIt.I.get())),
        ListenableProvider(create: (_) => CreateTodoController(GetIt.I.get())),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TodosPage(),
      theme: AppTheme.getLightTheme,
      darkTheme: AppTheme.getDarkTheme,
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.delegate.supportedLocales,
    );
  }
}
