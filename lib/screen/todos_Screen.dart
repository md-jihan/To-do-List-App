import 'package:flutter/material.dart';

import '../models/get_all_todos.dart';
import 'delete_button.dart';
import 'add_and_update_todo.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemBuilder: (context, index) {
            final item = todoList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addAndUpdateScreen(items: item),
                  ),
                );
              },
              child: Card(
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
                          DeleteButton(id: item.sId ?? ""),
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
              ),
            );
          },
        );
  }
}
