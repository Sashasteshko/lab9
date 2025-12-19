import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Відновлення")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_reset, size: 80, color: Colors.orangeAccent),
              const SizedBox(height: 20),

              const Text(
                "Відновлення паролю",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Введіть ваш E-mail',
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Це поле обов\'язкове';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Введіть дійсний E-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Інструкції надіслано на пошту!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Скинути пароль'),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Повернутися назад'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}