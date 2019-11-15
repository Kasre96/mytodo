import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/Task.dart';
import 'package:todoey/providers/task_provider.dart';
import 'package:todoey/utils/constants.dart';

class TasksScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String taskTitle;

  @override
  Widget build(BuildContext context) {
    //var Provider.of<TaskProvider>(context)._tasks = Provider.of<TaskProvider>(context)._tasks;
    return ChangeNotifierProvider(
        builder: (context) => TaskProvider(),
        child: Consumer<TaskProvider>(
          builder: (context, tasksProvider, child) {
            return Scaffold(
              backgroundColor: kPrimColor,
              body: Builder(
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.menu),
                                        color: Colors.white,
                                        iconSize: 30.0,
                                        onPressed: () {
                                          //
                                        },
                                      ),
                                      Text(
                                        'Todoey',
                                        style: TextStyle(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 30.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '${tasksProvider.taskCount} Tasks',
                                    style: TextStyle(
                                      color: kWhiteColor,
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: kBorderRadius,
                              ),
                              child: ListView.builder(
                                itemCount: tasksProvider.taskCount,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      ListTile(
                                        dense: true,
                                        title: Text(
                                          tasksProvider.tasks[index]
                                              .title,
                                          style: TextStyle(
                                            decoration: tasksProvider
                                                    .tasks[index].isDone
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                        onLongPress: () {
                                          tasksProvider.deleteTask(tasksProvider.tasks[index]);
                                        },
                                        trailing: Checkbox(
                                          value:
                                              tasksProvider.tasks[index].isDone
                                                  ? true
                                                  : false,
                                          checkColor: kWhiteColor,
                                          activeColor: kPrimColor,
                                          onChanged: (newValue) {
                                            tasksProvider.updateTask(tasksProvider.tasks[index]);
                                          },
                                        ),
                                      ),
                                      Divider()
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            color: Color(0XFF757575),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: kBorderRadius,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(24.0),
                              child: ListView(
                                children: <Widget>[
                                  Text(
                                    'Add Task',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Form(
                                    autovalidate: true,
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                            keyboardType: TextInputType.text,
                                            onSaved: (value) {
                                              taskTitle = value;
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value == '') {
                                                return 'Field required';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'task here...')),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        ButtonTheme(
                                          minWidth: double.infinity,
                                          child: MaterialButton(
                                            onPressed: () async {
                                              var form = _formKey.currentState;

                                              if (form.validate()) {
                                                form.save();

                                                Task newTask =
                                                    Task(title: taskTitle);

                                                try {
                                                  tasksProvider.addTask(newTask);

                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  print(e.toString());
                                                }
                                              } else {
                                                print('Error');
                                              }
                                            },
                                            textColor: Colors.white,
                                            color: kPrimColor,
                                            height: 50,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                            child: Text(
                                              'ADD',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      });
                },
              ),
            );
          },
        ));
  }
}
