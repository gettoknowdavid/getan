import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/utils/string_helpers.dart';
import '../../domain/entities/todo_category.dart';
import '../models/todo_model.dart';

StoreRef store = intMapStoreFactory.store('${env['TODO_STORE']}');

abstract class TodoLocalDataSource {
  Future<void> addTodo(TodoModel todo);
  Future<List<TodoModel>> getTodos();
  Future<void> removeTodo(TodoModel todo);
  Future<List<TodoModel>> sortByCategory(TodoCategory category);
  Future<List<TodoModel>> sortByDateAsc();
  Future<List<TodoModel>> sortByDateDesc();
  Future<void> updateTodo(TodoModel todo);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Database database;
  TodoLocalDataSourceImpl({@required this.database});

  @override
  Future<void> addTodo(TodoModel todo) async {
    await store.add(database, todo.toJson());
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    final finder = Finder(sortOrders: [SortOrder(Field.key, false)]);
    final records = await store.find(database, finder: finder);
    return records.map((e) => TodoModel.fromJson(e.value)).toList();
  }

  @override
  Future<void> removeTodo(TodoModel todo) async {
    final finder = Finder(filter: Filter.equals('id', todo.id));
    await store.delete(database, finder: finder);
  }

  @override
  Future<List<TodoModel>> sortByCategory(TodoCategory category) async {
    final _category = categoryToString(category);
    switch (category) {
      case TodoCategory.none:
        final finder = Finder(sortOrders: [SortOrder(Field.key, false, true)]);
        final records = await store.find(database, finder: finder);
        return records.map((e) => TodoModel.fromJson(e.value)).toList();
      default:
        final finder = Finder(filter: Filter.equals('category', _category));
        final records = await store.find(database, finder: finder);
        return records.map((e) => TodoModel.fromJson(e.value)).toList();
    }
  }

  @override
  Future<List<TodoModel>> sortByDateAsc() async {
    final finder = Finder(sortOrders: [SortOrder(Field.key, true)]);
    final records = await store.find(database, finder: finder);
    return records.map((e) => TodoModel.fromJson(e.value)).toList();
  }

  @override
  Future<List<TodoModel>> sortByDateDesc() async {
    final finder = Finder(sortOrders: [SortOrder(Field.key, false)]);
    final records = await store.find(database, finder: finder);
    return records.map((e) => TodoModel.fromJson(e.value)).toList();
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final finder = Finder(filter: Filter.equals('id', todo.id));
    await store.update(database, todo.toJson(), finder: finder);
  }
}
