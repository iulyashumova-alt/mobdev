import 'dart:io'; // 
import 'package:http/http.dart' as http; //
import 'package:command_runner/command_runner.dart';

const version = '0.0.1'; // 

// ... (existing const version declaration and printUsage function)

void main(List<String> arguments) async { // main is now async and awaits the runner
  var runner = CommandRunner(); // Create an instance of your new CommandRunner
  await runner.run(arguments); // Call its run method, awaiting its Future<void>
}