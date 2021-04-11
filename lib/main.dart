
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Todo List',
        home: new TodoList()
    );
  }
}

class TodoList extends StatefulWidget{
  @override
  createState()=>new TodoListState();
}

class TodoListState extends State<TodoList>{
  @override
  List<String> todoItems=[];
  void addTodoItem(String task){
   if(task.length>0){
     setState(() {
       todoItems.add(task);
     });
   }
  }

  Widget buildTodoList(){
    return new ListView.builder(
      itemBuilder: (context,index){
        if(index<todoItems.length){
          return buildTodoItem(todoItems[index],index);
        }
      },
    );
  }

  Widget buildTodoItem(String todoText, int index){
    return new ListTile(
      title:new Text (todoText),
      onTap: ()=>promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Todo List')
      ),
      body: buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: pushAddScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );
  }

  void pushAddScreen() {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      addTodoItem(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter something to do...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }

  void removeTodoItem(int index) {
    setState(() => todoItems.removeAt(index));
  }

  void promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }
}


