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
  final String filePath;

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
    Model('Model 1', ['Class A', 'Class B'], [224, 224], 'This is Model 1, it supports image input size of 224x224.', '/path/to/model1.pt'),
    Model('Model 2', ['Class X', 'Class Y', 'Class Z'], [512, 512], 'Model 2 is a powerful model with image input size of 512x512.', '/path/to/model2.pt'),
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
                  decoration: InputDecoration(labelText: 'Classes (comma-separated)'),
                  onChanged: (value) {
                    classes = value.split(',');
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Input Size (width,height)'),
                  onChanged: (value) {
                    List<String> sizes = value.split(',');
                    inputSize = sizes.map((size) => int.tryParse(size.trim()) ?? 0).toList();
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'File Path'),
                  onChanged: (value) {
                    filePath = value;
                  },
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
                Model newModel = Model(name, classes, inputSize, description, filePath);
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
          return ListTile(            title: Text(models[index].name),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewModelDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
