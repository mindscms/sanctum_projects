import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sanctum/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }

}

class LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  void submit () {
    Provider.of<Auth>(context, listen: false).login(
        credentials: {
          'email': _email,
          'password': _password,
        }
    );

    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: 'sami@gmail.com',
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'email@email.com'
                  ),
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                TextFormField(
                  initialValue: '123123123',
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '123123123'
                  ),
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      _formKey.currentState.save();

                      this.submit();
                    },
                  ),
                )

              ],
            ),
          ),
        ),

      )
    );
  }
}
