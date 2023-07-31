import 'package:flutter/material.dart';
import 'package:java_league/providers/auth_provider.dart';
import 'package:provider/provider.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'login': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isSignup() => _authMode == AuthMode.signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    if (_isLogin()) {
      // Login
      await auth.login(
        _authData['login']!,
        _authData['password']!,
      );
    } else {
      // Registrar
      await auth.register(
        _authData['login']!,
        _authData['password']!,
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Form(
        key: _formKey,
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
              controller: _passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                labelText: 'Senha',
              ),
              onSaved: (senha) => _authData['password'] = senha ?? '',
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Informe uma senha válida';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 8),
            if (_isSignup())
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  labelText: 'Confirmar Senhar',
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _isLogin()
                    ? null
                    : (_password) {
                  final password = _password ?? '';
                  if (password != _passwordController.text) {
                    return 'Senhas informadas não conferem.';
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authMode == AuthMode.login ? 'Entrar' : 'Registrar',
                ),
              ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                _isLogin() ? 'Criar conta?' : 'Fazer Login?',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
