import 'dart:developer';

class Logger {
  static void d(Object? message) {
    log(
      message.toString(),
      name: 'DEBUG',
    );
  }

  static void i(Object? message) {
    log(
      message.toString(),
      name: 'INFO',
    );
  }

  static void e(Object? e, StackTrace? s) {
    log(
      '',
      name: 'ERROR',
      error: e,
      stackTrace: s,
    );
  }
}
