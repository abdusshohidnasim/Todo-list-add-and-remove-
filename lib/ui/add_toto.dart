import 'package:flutter/material.dart';
import '../model/model_class.dart';
import '../servise/db_helper.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final DbHelper dbHelper = DbHelper();
  final _formKey = GlobalKey<FormState>();

  void addTodo() async {
    if (!_formKey.currentState!.validate()) return;

    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: titleController.text,
      description: descController.text,
    );

    await dbHelper.insertTodo(todo);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Todo added successfully')),
    );

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Your Todo has been added."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))
        ],
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo"), backgroundColor: Colors.red[300]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: (v) => v!.isEmpty ? "Enter title" : null,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descController,
                minLines: 3,
                maxLines: 6,
                validator: (v) => v!.isEmpty ? "Enter description" : null,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[300]),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[300]),
                      onPressed: addTodo,
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
