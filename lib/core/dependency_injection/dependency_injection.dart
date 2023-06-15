import 'package:get_it/get_it.dart';

import '../../features/domain/controllers/task/tasks_state.dart';

class DependencyInjection {
  DependencyInjection._();

  static void inject() {
    GetIt.I.registerLazySingleton(() => TodosState());
  }
}