import 'package:flutter/material.dart';
import 'package:flutter_application_4/api_services/api_services.dart';
import 'package:flutter_application_4/models/get_all_todos.dart';
import 'screen/add_and_update_todo.dart';
import 'package:flutter_application_4/screen/todos_Screen.dart';

class ToDoListHomeScreen extends StatefulWidget {
  const ToDoListHomeScreen({super.key});

  @override
  State<ToDoListHomeScreen> createState() => _ToDoListHomeScreenState();
}

class _ToDoListHomeScreenState extends State<ToDoListHomeScreen> {
  GatAllTodosModel getAllTodoModel = GatAllTodosModel();
  List<Items> inCompleteTodo = [];
  List<Items> completeTodo = [];
  bool isLoading = false;
  getAllTodos() async {
    setState(() {
      isLoading = true;
    });
    await ApiService()
        .getAllTodos()
        .then((value) {
          getAllTodoModel = value;
          for (var todo in value.items!) {
            if (todo.isCompleted == true) {
              completeTodo.add(todo);
            } else {
              inCompleteTodo.add(todo);
            }
            setState(() {});
          }
          isLoading = false;

          setState(() {});
        })
        .onError((error, stackTrace) {
          debugPrint(error.toString());
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("To-Do List"),
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 10),
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            tabs: [Text("All"), Text("Incomplete"), Text("Complete,")],
          ),
        ),

        body:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                  children: [
                    TodosScreen(todoList: getAllTodoModel.items ?? []),
                    TodosScreen(todoList: inCompleteTodo),
                    TodosScreen(todoList: completeTodo),
                  ],
                ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool loading = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const addAndUpdateScreen(),
              ),
            );
            if (loading == true) {
              getAllTodos();
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
