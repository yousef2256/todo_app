import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/data/models/isar_todo.dart';
import 'package:todo_app/data/repository/isar_todo_repo.dart';
import 'package:todo_app/domain/repository/todo_repo.dart';
import 'package:todo_app/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();
  //open isar database
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  //initialize the repo with isar database
  final isarTodoRepo = IsarTodoRepo(isar);
  //run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final TodoRepo? todoRepo;
  const MyApp({super.key, this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo!),
    );
  }
}
