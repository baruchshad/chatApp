import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
  ) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail;
  String _userName;
  String _userPassword;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail,
        _userPassword,
        _userName,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email address'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a value email address';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _userEmail = newValue;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter at least a username';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userName = newValue;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _userPassword = newValue;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(
                    child: _isLogin ? Text('Login') : Text('Sign up'),
                    onPressed: () {}),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: _isLogin
                      ? Text('Create new Account')
                      : Text('Login Instead'),
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
