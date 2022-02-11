import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';

class AddTodo extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Todo"),
        ),
        body: BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            if (state is AddedTodo) {
              Navigator.pop(context);
              return;
            } else if (state is AddTodoError) {
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white);
            }
          },
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: _body(context),
          ),
        ));
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
            final message = _textEditingController.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
          child: _addBtn(context),
        ),
      ],
    );
  }

  Widget _addBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) {
              return CircularProgressIndicator();
            }
            return Text(
              "Add Todo ",
              style: TextStyle(color: Colors.white, fontSize: 18),
            );
          },
        ),
      ),
    );
  }
}
