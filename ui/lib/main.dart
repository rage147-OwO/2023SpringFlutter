import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(ModelManagementApp());
}

class Model {
  final String name;
  final String filePath;
  final List<String> classes;
  final List<int> inputSize;
  final int nc;
  final String description;

  Model(this.name, this.filePath, this.classes, this.inputSize, this.description)
      : nc = classes.length;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'filePath': filePath,
      'classes': classes,
      'inputSize': inputSize,
      'description': description,
    };
  }

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      json['name'],
      json['filePath'],
      List<String>.from(json['classes']),
      List<int>.from(json['inputSize']),
      json['description'],
    );
  }
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
  List<Model> models = [];

  @override
  void initState() {
    super.initState();
    _loadModelList();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addNewModel();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _loadModelList() async {
    try {
      final file = File('model_list.json');
      if (await file.exists()) {
        final jsonContent = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonContent);
        setState(() {
          models = jsonList.map((json) => Model.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Failed to load model list: $e');
    }
  }

  Future<void> _saveModelList() async {
    try {
      final file = File('model_list.json');
      final List<Map<String, dynamic>> jsonList =
      models.map((model) => model.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Failed to save model list: $e');
    }
  }

  Future<void> _addNewModel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pt'],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      String fileName = result.files.single.name;
      String modelName = fileName.replaceAll('.pt', '');

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          String classes = '';
          String inputSize = '';
          String description = '';

          return AlertDialog(
            title: Text('Add New Model'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Classes (comma-separated)'),
                    onChanged: (value) {
                      classes = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Input Size (width,height)'),
                    onChanged: (value) {
                      inputSize = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  List<String> classList = classes.split(',');
                  List<int> sizeList = inputSize.split(',').map((size) => int.parse(size.trim())).toList();
                  Model newModel = Model(modelName, filePath, classList, sizeList, description);
                  setState(() {
                    models.add(newModel);
                  });
                  Navigator.pop(dialogContext);
                  _saveModelList();  // 모델 리스트 저장
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteModel(int index) {
    setState(() {
      models.removeAt(index);
      _saveModelList();  // 모델 리스트 저장
    });
  }
}

