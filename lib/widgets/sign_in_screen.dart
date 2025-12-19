import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'reset_password_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.lock_open_rounded, size: 80, color: Colors.teal),
                const SizedBox(height: 30),
                const Text(
                  'Авторизація',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail (Логін)',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  // ВАЛІДАЦІЯ
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть E-mail';
                    }
                    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Введіть коректний E-mail';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть пароль';
                    }
                    if (value.length < 7) {
                      return 'Пароль має бути не менше 7 символів';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Дані валісні! Вхід...')),
                      );
                    }
                  },
                  child: const Text('Увійти'),
                ),
                const SizedBox(height: 16),

                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text('Реєстрація'),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                    );
                  },
                  child: const Text('Забули пароль?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}