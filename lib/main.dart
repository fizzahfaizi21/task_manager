import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor:
            Color.fromARGB(255, 236, 199, 252), // Very light purple background
      ),
      home: TaskListScreen(),
    );
  }
}

// Task model class
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Controller for the text input field
  final TextEditingController _taskController = TextEditingController();

  // List to store tasks
  List<Task> _tasks = [];

  // Method to add a task
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: _taskController.text));
        _taskController.clear();
      });
    }
  }

  // Method to toggle task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  // Method to delete a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: TextStyle(
              color: Colors.white), // White text for better visibility
        ),
        backgroundColor: Colors.purple, // Purple background for app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text input field and Add button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter task name',
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.purple, // Match button color with theme
                    foregroundColor: Colors.white, // White text on button
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Task list with full functionality
            Expanded(
              child: _tasks.isEmpty
                  ? Center(child: Text('No tasks yet. Add some above!'))
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              _tasks[index].name,
                              style: TextStyle(
                                decoration: _tasks[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: _tasks[index].isCompleted
                                    ? Colors.black
                                    : Colors.black,
                              ),
                            ),
                            leading: Checkbox(
                              value: _tasks[index].isCompleted,
                              onChanged: (bool? value) {
                                _toggleTaskCompletion(index);
                              },
                              activeColor:
                                  Colors.purple, // Purple checkbox when checked
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteTask(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
