import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class ModelManager {
  static Future<List<String>> getAppFolderFiles() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> entities = appDir.listSync();

    List<String> fileNames = [];
    for (FileSystemEntity entity in entities) {
      if (entity is File) {
        String filePath = entity.path;
        fileNames.add(filePath);
        print(filePath);
      }
    }

    return fileNames;
  }

  static Future<String?> openAndCopyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();

      String fileName = result.files.single.name;
      String newPath = '${appDocDir.path}/$fileName';

      File file = File(result.files.single.path!);
      File copiedFile = await file.copy(newPath);

      return copiedFile.path;
    } else {
      return null;
    }
  }

  static Future<void> saveTextToFile(String text) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/data.txt';

    File file = File(filePath);
    await file.writeAsString(text);
  }

  static Future<String?> readTextFromFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/data.txt';

    File file = File(filePath);
    if (await file.exists()) {
      String text = await file.readAsString();
      return text;
    }

    return null;
  }
}
