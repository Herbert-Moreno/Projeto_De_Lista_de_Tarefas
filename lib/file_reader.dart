import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> get _localPath async {
    final appdirectory = await getApplicationDocumentsDirectory();
    final apppath = appdirectory.path;
    return apppath;
}

Future readJsonFile() async {
  try {
    final path = await _localPath;
    final file = File('$path/ListTarefas.json');

    if (await file.exists()) {
      final contents = await file.readAsString();
      return jsonDecode(contents) as Map<String, dynamic>;
    }
    else {
      final Map<String, dynamic> initialData = {
        "tasks": []
      }; // JSON inicial (mapa vazio)
      await file.writeAsString(jsonEncode(initialData));
      return initialData;
    }
  } catch (e) {
    throw Exception('Erro ao ler o arquivo: $e');
  }
}

Future writeJsonFile(dynamic data) async {
  final Map<String, dynamic> writeFile = {
    "tasks": data
  };

  try {
    final path = await _localPath;
    final file = File('$path/ListTarefas.json');

    if (await file.exists()) {
      file.writeAsString(jsonEncode(writeFile));
    }

    else {
      file.writeAsString(jsonEncode(writeFile).toString());
    }
  } catch (e) {
    throw Exception('Erro ao ler o arquivo: $e');
  }
}