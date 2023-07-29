import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // final _formKey = Global
  Map<String, String> _authData = {
    'login': '',
    'senha': ''
  };

  void _submit () {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Login',
              ),
              onSaved: (login) => _authData['login'] = login ?? '',
              validator: (_login) {
                final login = _login ?? '';
                if (login.isEmpty || login.length < 5) {
                  return 'Informe um login válida';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                labelText: 'Senha',
              ),
              onSaved: (senha) => _authData['senha'] = senha ?? '',
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Informe uma senha válida';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () { _submit(); }, child: Text('Entrar'))
          ],
        ),
      ),
    );
  }
}
