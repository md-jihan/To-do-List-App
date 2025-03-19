import 'package:flutter/material.dart';
import 'package:flutter_application_4/api_services/api_services.dart';
import 'package:flutter_application_4/models/get_all_todos.dart';
import 'package:flutter_application_4/utils/common_toast.dart';
// import 'package:flutter_application_4/api_services/api_services.dart';

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

  @override
  void initState() {
    if (widget.items != null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Add To-do"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
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
            ApiService()
                .addTodos(
                  title.text.toString(),
                  Description.text.toString(),
                  isComplete,
                )
                .then((value) {
                  Navigator.pop(context, true);
                })
                .onError((error, stackTrace) {
                  debugPrint(error.toString());
                });
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }
}
