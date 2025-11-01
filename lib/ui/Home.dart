// ),
// trailing: IconButton(
// icon: const Icon(Icons.delete, color: Colors.red),
// onPressed: () async {
// final confirm = await showDialog<bool>(
// context: context,
// builder: (ctx) => AlertDialog(
// title: const Text("Delete Todo"),
// content: const Text("Are you sure you want to delete this todo?"),
// actions: [
// TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
// TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Delete")),
// ],
// ),
// );
// if (confirm ?? false) {
// await dbHelper.deleteTodo(todo.id);
// refresh();
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(content: Text("Todo deleted")),
// );
// }
// },
// ),
// ),
// );
// },
// );
// },
// ),
// ),
// floatingActionButton: FloatingActionButton(
// backgroundColor: Colors.red[300],
// child: const Icon(Icons.add),
// onPressed: () async {
// await Navigator.push(
// context,
// MaterialPageRoute(builder: (_) => const AddTodoPage()),
// );
// refresh();
// },
// ),