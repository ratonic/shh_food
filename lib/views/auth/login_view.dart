import 'package:flutter/material.dart';
import 'package:shh_food/services/auth_services.dart'; // Importa el servicio de autenticación
import 'package:shh_food/views/home/my_home_page.dart'; // Importa la pantalla principal

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final result = await AuthService().loginUser(
        email: email,
        password: password,
      );

      setState(() => isLoading = false);

      if (result != null) {
        // Inicio de sesión exitoso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: '¡Shh! Food')),
        );
      } else {
        // Error en el inicio de sesión
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correo o contraseña incorrectos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Correo electrónico'),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => email = value,
                      validator: (value) => value!.isEmpty || !value.contains('@') ? 'Correo inválido' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      onChanged: (value) => password = value,
                      validator: (value) => value!.isEmpty ? 'Contraseña requerida' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: loginUser,
                      child: const Text('Iniciar Sesión'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}