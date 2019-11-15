import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todoey/models/Task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [
    Task(title: 'My first task'),
    Task(title: 'My second task'),
    Task(title: 'My third task'),
  ];

  // tasks getter
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  } 

  // tasks lenth
  int get taskCount {
    return _tasks.length;
  }

  // add task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // update task
  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  // deleteTask
  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}