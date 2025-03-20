import 'package:flutter/material.dart';
import '../api_services/api_services.dart';
import '../home.dart';
import '../models/get_all_todos.dart';
import '../utils/common_toast.dart';
// import 'package:mhapp_todolist/api_services/api_services.dart';

class addAndUpdateScreen extends StatefulWidget {
  final Items? items;
  const addAndUpdateScreen({super.key, this.items});

  @override
  State<addAndUpdateScreen> createState() => _addAndUpdateScreenState();
}

class _addAndUpdateScreenState extends State<addAndUpdateScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController Description = TextEditingController();
  bool isComplete = false;
  bool isLoading = false;

  @override
  void initState() {
    if (widget.items != null) {
      title.text = widget.items?.title ?? "";
      Description.text = widget.items?.description ?? "";
      isComplete = widget.items?.isCompleted ?? false;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.items == null ? "Add To-do" : "Update To-do"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              autofocus: widget.items == null ? true : false,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(),
              ),
              controller: title,
            ),
            SizedBox(height: 10),
            TextField(
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
              controller: Description,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Complete",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: isComplete,
                  activeColor: Theme.of(context).colorScheme.inversePrimary,
                  onChanged: (bool value) {
                    setState(() {
                      isComplete = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (title.text.isEmpty) {
            commonToast(context, "Please enter title");
          } else if (Description.text.isEmpty) {
            commonToast(context, "Please enter description");
          } else {
            setState(() {
              isLoading = true;
            });
            if (widget.items == null) {
              ApiService()
                  .addTodos(
                    title.text.toString(),
                    Description.text.toString(),
                    isComplete,
                  )
                  .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context, true);
                  })
                  .onError((error, stackTrace) {
                    debugPrint(error.toString());
                    setState(() {
                      isLoading = false;
                    });
                    commonToast(context, "Something went wrong");
                  });
            } else {
              ApiService()
                  .updateTodo(
                    widget.items!.sId!,
                    title.text.toString(),
                    Description.text.toString(),
                    isComplete,
                  )
                  .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ToDoListHomeScreen(),
                      ),
                    );
                  })
                  .onError((error, StackTrace) {
                    debugPrint(error.toString());

                    setState(() {
                      isLoading = false;
                    });
                    commonToast(context, "Something went wrong");
                  });
            }
          }
        },
        child:
            isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.done),
      ),
    );
  }
}
