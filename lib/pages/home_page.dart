import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskme/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeight;
  String? _newTaskContent;
  Box? _box;
  @override
  void initState() {
    super.initState();
  }

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
        body: _tasksView(),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: _deviceWidth * 0.01),
          child: _addTaskButton(),
        ),
      ),
    );
  }

  Widget _tasksView() {
    return FutureBuilder(
      // future: Future.delayed(Duration(seconds: 2)),
      future: Hive.openBox('tasks'), //
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.connectionState == ConnectionState.done) {
          _box = _snapshot.data;
          return _tasksList();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _tasksList() {
    // Task _newTask =
    //     Task(content: "Goto Gym", timestamp: DateTime.now(), done: false);
    // _box?.add(_newTask.toMap());
    List tasks = _box!.values.toList();
    return Padding(
      padding: EdgeInsets.all(_deviceWidth * 0.03),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, _index) {
          var task = Task.fromMap(tasks[_index]);
          return Card(
            child: ListTile(
              title: Text(
                task.content,
                style: TextStyle(
                    decoration: task.done ? TextDecoration.lineThrough : null),
              ),
              subtitle: Text(task.timestamp.toString()),
              trailing: Icon(
                  task.done
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                  color: Colors.red),
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
            content: TextField(
              onSubmitted: (_) {
                if (_newTaskContent != null) {
                  var _task = Task(
                      content: _newTaskContent!,
                      timestamp: DateTime.now(),
                      done: false);
                  _box!.add(_task.toMap());
                }
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(_context);
                });
              },
              onChanged: (value) {
                setState(() {
                  _newTaskContent = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Task content',
              ),
            ),
          );
        });
  }
}
