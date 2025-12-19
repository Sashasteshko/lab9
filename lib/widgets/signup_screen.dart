import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Реєстрація")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Створення профілю',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Ім'я користувача",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введіть ім'я";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail (Логін)',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть E-mail';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Некоректний формат E-mail';
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
                    helperText: 'Не менше 7 символів', // Підказка знизу
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть пароль';
                    }
                    if (value.length < 7) {
                      return 'Мінімум 7 символів';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Успішна реєстрація!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Зареєструватися'),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Вже є акаунт? Увійти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}