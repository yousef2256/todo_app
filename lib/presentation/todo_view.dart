import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/todo.dart';
import 'package:todo_app/presentation/todo_cupit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textInputControl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textInputControl),
        actions: [
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textInputControl.text);
              Navigator.of(context).pop();
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // todo cubit
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBox(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return ListTile(
                //text
                title: Text(todo.text),

                //check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),
                trailing: IconButton(
                  onPressed: () => todoCubit.deleteTodo(todo),
                  icon: const Icon(Icons.cancel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
