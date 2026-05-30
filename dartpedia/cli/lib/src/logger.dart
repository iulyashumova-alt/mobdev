import 'dart:io';
import 'package:logging/logging.dart';



Logger initFileLogger(String name) {
  // Enables logging from child loggers.
  hierarchicalLoggingEnabled = true;
  

  // Create a logger instance with the provided name.
  final logger = Logger(name);
  final now = DateTime.now();

  final scriptFile = File(Platform.script.toFilePath());

  final projectDir = scriptFile.parent.parent.path;

  

  // Create a 'logs' directory if it doesn't exist.
  final dir = Directory('$projectDir/logs');


  if (!dir.existsSync()) dir.createSync();

  // Create a log file with a unique name based on
  // the current date and logger name.
  final logFile = File(
    '${dir.path}/${now.year}_${now.month}_${now.day}_$name.txt',
  );

  // The rest of the function will be added below.
  // ...


  // The rest of the function will be added below.
  // ...

  print('Полный путь к файлу лога: ${logFile.path}');
  logger.level = Level.ALL;

  // Listen for log records and write each one to the log file.
  logger.onRecord.listen((record) {
    final msg =
        '[${record.time} - ${record.loggerName}] ${record.level.name}: ${record.message}';
    logFile.writeAsStringSync('$msg \n', mode: FileMode.append);
  });

  return logger;
}
