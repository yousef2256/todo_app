import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/todo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  //Reference todo repo
  final TodoRepo todoRepo;

  //Constructor initializes the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }
  //load
  Future<void> loadTodos() async {
    //fetch the fetched list as the new state
    final todoList = await todoRepo.getTodos();

    //emit the fetched list as the new state
    emit(todoList);
  }

  //add
  Future<void> addTodo(String text) async {
    //   //create a new todo with unique Id
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );
    //Save the new todo to repo
    await todoRepo.addTodo(newTodo);

    //re-lode
    loadTodos();
  }

  //delete
  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    //re-load
    loadTodos();
  }

  //toggle
  Future<void> toggleCompletion(Todo todo) async {
    final updateTodo = todo.toggleCompletion();

    await todoRepo.updateTodo(updateTodo);

    //re-load
    loadTodos();
  }
}
