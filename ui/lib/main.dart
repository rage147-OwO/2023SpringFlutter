import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(ModelManagementApp());
}

class Model {
  final String name;
  final List<String> classes;
  final List<int> inputSize;
  final int nc;
  final String description;
  String filePath;

  Model(this.name, this.classes, this.inputSize, this.description, this.filePath)
      : nc = classes.length;
}

class ModelManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Model Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ModelListScreen(),
    );
  }
}

class ModelListScreen extends StatefulWidget {
  @override
  _ModelListScreenState createState() => _ModelListScreenState();
}

class _ModelListScreenState extends State<ModelListScreen> {
  List<Model> models = [
    Model('Model 1', ['Class A', 'Class B'], [224, 224],
        'This is Model 1, it supports image input size of 224x224.',
        '/path/to/model1.pt'),
    Model('Model 2', ['Class X', 'Class Y', 'Class Z'], [512, 512],
        'Model 2 is a powerful model with image input size of 512x512.',
        '/path/to/model2.pt'),
  ];

  void _deleteModel(int index) {
    setState(() {
      models.removeAt(index);
    });
  }

  void _addNewModelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = '';
        List<String> classes = [];
        List<int> inputSize = [];
        String description = '';
        String filePath = '';

        return AlertDialog(
          title: Text('Add New Model'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Classes (comma-separated)'),
                  onChanged: (value) {
                    classes = value.split(',');
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Input Size (width,height)'),
                  onChanged: (value) {
                    List<String> sizes = value.split(',');
                    inputSize = sizes.map((size) =>
                    int.tryParse(size.trim()) ?? 0).toList();
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    filePath = (await openAndCopyFile())!;
                  },
                  child: Text("Select model(.pt) file"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Model newModel = Model(
                    name, classes, inputSize, description, filePath);
                setState(() {
                  models.add(newModel);
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model List'),
      ),
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(models[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Classes: ${models[index].classes.join(', ')}'),
                Text('Input Size: ${models[index].inputSize[0]}x${models[index].inputSize[1]}'),
                Text('Class Count: ${models[index].nc}'),
                Text('Description: ${models[index].description}'),
                Text('File Path: ${models[index].filePath}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteModel(index);
              },
            ),
            onTap: () {
              // 항목 선택 시 동작
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _addNewModelDialog();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              print(getAppFolderFiles());
            },
            child: Icon(Icons.folder_open_sharp),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<List<String>> getAppFolderFiles() async {
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



  Future<String?> openAndCopyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    Directory appDocDir = await getApplicationDocumentsDirectory();

    File file = File(result!.files.single.path!);
    String newPath = '${appDocDir.path}/${result.files.single.name}';
    File copiedFile = await file.copy(newPath);


    return copiedFile.path;
  }

}



Future<File> copyFile(File sourceFile, String newPath) async {
  try {
    // 파일을 복제하기 전에 존재하는지 확인합니다.
    if (await sourceFile.exists()) {
      // 목적지 경로에 동일한 파일 이름이 있는 경우를 처리하기 위해 파일 이름을 추출합니다.
      String fileName = sourceFile.path.split('/').last;

      // 복제할 파일의 경로를 생성합니다.
      String copiedFilePath = '$newPath/$fileName';

      // 파일을 복제합니다.
      await sourceFile.copy(copiedFilePath);

      // 복제된 파일을 반환합니다.
      return File(copiedFilePath);
    } else {
      throw FileSystemException('Source file does not exist.');
    }
  } catch (e) {
    // 복제 과정에서 발생한 오류를 처리합니다.
    print('Error copying file: $e');
    throw e;
  }
}



Future<void> saveTextToFile(String text) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.path}/data.txt';

  File file = File(filePath);
  await file.writeAsString(text);
}

Future<String?> readTextFromFile() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.path}/data.txt';

  File file = File(filePath);
  if (await file.exists()) {
    String text = await file.readAsString();
    return text;
  }

  return null;
}



