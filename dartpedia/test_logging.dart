import 'dart:io';
import 'package:logging/logging.dart';

Logger initFileLogger(String name) {
  hierarchicalLoggingEnabled = true;
  final logger = Logger(name);
  final now = DateTime.now();

  // Используем текущую директорию проекта
  final projectDir = Directory.current;
  print('Текущая директория проекта: ${projectDir.path}');

  final logDir = Directory('${projectDir.path}/logs');
  print('Путь к папке логов: ${logDir.path}');

  if (!logDir.existsSync()) {
    logDir.createSync(recursive: true);
    print('Создана папка для логов: ${logDir.path}');
  }

  String pad(int value) => value.toString().padLeft(2, '0');
  final formattedDate = '${now.year}-${pad(now.month)}-${pad(now.day)}';
  final logFile = File('${logDir.path}/jttname.txt');
  print('Полный путь к файлу лога: ${logFile.path}');

  logger.level = Level.ALL;

  logger.onRecord.listen((record) async {
    try {
      final msg = '[${record.time} - ${record.loggerName}] ${record.level.name}: ${record.message}';
      await logFile.writeAsString('$msg\n', mode: FileMode.append, flush: true);
      print('Записан лог: $msg');
    } catch (e) {
      print('Ошибка записи в лог-файл: $e');
    }
  });

  return logger;
}

void main() {
  final testLogger = initFileLogger('test');
  testLogger.info('Тестовое информационное сообщение');
  testLogger.warning('Тестовое предупреждение');
  testLogger.severe('Критическая ошибка для теста');
  print('Проверьте папку logs/ — там должен быть файл с сегодняшней датой и именем test.txt');
}
