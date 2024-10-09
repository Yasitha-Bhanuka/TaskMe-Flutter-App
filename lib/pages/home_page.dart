import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeight;
  String? _newTaskContent;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    print("Input value: $_newTaskContent");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 5.0,
          shadowColor: Colors.black,
          toolbarHeight: _deviceHeight * 0.15,
          centerTitle: true,
          title: const Text(
            'TaskMe',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
        ),
        body: _tasksList(),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: _deviceWidth * 0.01),
          child: _addTaskButton(),
        ),
      ),
    );
  }

  Widget _tasksList() {
    return Padding(
      padding: EdgeInsets.all(_deviceWidth * 0.03),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Task $index'),
              subtitle: Text(DateTime.now().toString()),
              trailing: const Icon(color: Colors.red, Icons.check_box_outlined),
            ),
          );
        },
      ),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      onPressed: _displayTaskPopup,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  void _displayTaskPopup() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text('Add New Task'),
            content: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _newTaskContent = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Task content',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("New task content: $_newTaskContent");
                    Navigator.of(_context).pop();
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          );
        });
  }
}
