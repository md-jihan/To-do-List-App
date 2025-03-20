import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../api_services/api_services.dart';
import '../home.dart';
import '../utils/common_toast.dart';

class DeleteButton extends StatefulWidget {
  final String id;
  const DeleteButton({super.key, required this.id});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLoading = true;
        });
        ApiService()
            .deleteTodos(widget.id)
            .then((value) {
              commonToast(
                context,
                "Delete Successfully",
                bgColor: Colors.green,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ToDoListHomeScreen()),
              );
              setState(() {
                isLoading = false;
              });
            })
            .onError((error, stackTrace) {
              debugPrint(error.toString());
              setState(() {
                isLoading = false;
              });
              commonToast(context, "Something went wrong");
            });
      },
      child: Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

        child:
            isLoading
                ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                )
                : Icon(Icons.delete_outline, color: Colors.redAccent),
      ),
    );
  }
}
