import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class EditTodo extends StatelessWidget {
  final Todo todo;
  EditTodo({Key? key, required this.todo}) : super(key: key);

  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _textEditingController.text = todo.todoMessage;
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 35,
                ),
              ),
            )
          ],
        ),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _body(context),
        )),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: InputDecoration(hintText: "Enter a Todo Message"),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<EditTodoCubit>(context)
                .updateTodo(todo, _textEditingController.text);
          },
          child: _updateBtn(context),
        ),
      ],
    );
  }

  Widget _updateBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "Update Todo ",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
