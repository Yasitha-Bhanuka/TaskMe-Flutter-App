import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceWidth, _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
    );
  }

  Widget _tasksList() {
    return ListView.builder(
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
    );
  }
}
