import 'package:todo_app/domain/todo.dart';

abstract class TodoRepo {
  //git list of todo
  Future<List<Todo>> getTodos();
  //add a new todo
  Future<void> addTodo(Todo newTodo);
  //update an existing todo
  Future<void> updateTodo(Todo newTodo);
  //delete a todo
  Future<void> deleteTodo(Todo newTodo);
}
