import 'package:isar/isar.dart';
import 'package:todo_app/data/models/isar_todo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';
import 'package:todo_app/domain/todo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar? db;

  IsarTodoRepo(Isar isar, {this.db});

  //get Todo
  @override
  Future<List<Todo>> getTodos() async {
    //fetch from db
    final todos = await db?.todoIsars.where().findAll();

    return todos!.map((todoIsar) => todoIsar.ToDomain()).toList();
  }

  //get todo
  @override
  Future<void> addTodo(Todo todo) async {
    //convert todo isar todo
    final todoIsar = TodoIsar.fromDomain(todo);
    //so that we can store it in our isar db
    return db!.writeTxn(() => db!.todoIsars.put(todoIsar));
  }

  //add todo
  @override
  Future<void> updateTodo(Todo todo) {
    //convert todo isar todo
    final todoIsar = TodoIsar.fromDomain(todo);
    //so that we can store it in our isar db
    return db!.writeTxn(() => db!.todoIsars.put(todoIsar));
  }

  //delete todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db?.writeTxn(() => db!.todoIsars.delete(todo.id));
  }
}
