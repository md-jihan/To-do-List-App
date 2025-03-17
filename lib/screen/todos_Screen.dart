import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/get_all_todos.dart';

class TodosScreen extends StatelessWidget {
  final List<Items> todoList;

  const TodosScreen({super.key, required this.todoList});

  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? Center(child: Text("Todo Not Found.", textScaleFactor: 2))
        : ListView.separated(
          separatorBuilder: (context, i) => const SizedBox(height: 10),
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final item = todoList[index];
            return Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.title ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      item.description ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        item.isCompleted == true ? 'Complete' : 'Incomplete',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}
