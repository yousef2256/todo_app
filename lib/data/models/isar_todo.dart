import 'package:isar/isar.dart';
import 'package:todo_app/domain/todo.dart';

//to generate isar object run : dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isComplete;

  //convert isar object -> pure todo to use in our app
  Todo ToDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isComplete,
    );
  }

  //convert pure todo object -> isar object to store is isar db
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isComplete = todo.isCompleted;
  }
}
