import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/data/repository.dart';
import 'package:todo_app/presentation/screen/add_todo_screen.dart';
import 'package:todo_app/presentation/screen/edit_todo_screen.dart';
import 'package:todo_app/presentation/screen/todos_screen.dart';

class AppRouter {
  late Repository repository;
  late TodosCubit todosCubit;
  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }
  Route? generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(value: todosCubit, child: TodoSrceen()));
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => AddTodoCubit(
                    repository: repository, todosCubit: todosCubit),
                child: AddTodo()));
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => EditTodoCubit(
                    repository: repository, todosCubit: todosCubit),
                child: EditTodo(
                  todo: todo,
                )));

      // return MaterialPageRoute(
      //     builder: (_) => EditTodo(
      //           todo: todo,
      //         ));
      default:
        return null;
    }
  }
}
