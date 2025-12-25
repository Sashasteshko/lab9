import 'package:flutter/material.dart';
import '../service/api_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 1. Ключ форми
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2. Контролери для полів
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 3. Сервіс API
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    // Очищення контролерів
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Метод реєстрації
  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      // Відправляємо запит на сервер
      await _apiService.postRequest(context, 'signup', {
        'username': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'created_at': DateTime.now().toIso8601String(),
      });

      // Примітка: Я прибрав Navigator.pop(context), щоб ви встигли
      // побачити повідомлення від сервера (успіх чи помилка).
      // Користувач зможе повернутися назад кнопкою "Вже є акаунт" або системною стрілкою.
    }
  }

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

                // Поле: Ім'я користувача
                TextFormField(
                  controller: _nameController, // !!! Контролер
                  decoration: const InputDecoration(
                    labelText: "Ім'я користувача",
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Введіть ім'я";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Поле: Email
                TextFormField(
                  controller: _emailController, // !!! Контролер
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail (Логін)',
                    prefixIcon: Icon(Icons.alternate_email),
                    border: OutlineInputBorder(),
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

                // Поле: Пароль
                TextFormField(
                  controller: _passwordController, // !!! Контролер
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    prefixIcon: Icon(Icons.lock_outline),
                    helperText: 'Не менше 7 символів',
                    border: OutlineInputBorder(),
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

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSignup, // Виклик функції
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Зареєструватися'),
                  ),
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