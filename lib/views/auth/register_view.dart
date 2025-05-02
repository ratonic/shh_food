import 'package:flutter/material.dart';
import 'package:shh_food/services/auth_services.dart';
import 'package:shh_food/views/home/my_home_page.dart'; // Importante para la navegación

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String phone = '';
  String role = 'cliente';

  bool isLoading = false;

  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
        return;
      }

      setState(() => isLoading = true);

      final result = await AuthService().registerUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        role: role,
      );

      setState(() => isLoading = false);

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result as String)),
        );
      } else {
        // Registro exitoso, navegar directamente a MyHomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: '¡Shh! Food')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      onChanged: (value) => name = value,
                      validator: (value) => value!.isEmpty ? 'Requerido' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Correo electrónico'),
                      onChanged: (value) => email = value,
                      validator: (value) => value!.isEmpty ? 'Requerido' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Teléfono'),
                      onChanged: (value) => phone = value,
                      validator: (value) => value!.isEmpty ? 'Requerido' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      onChanged: (value) => password = value,
                      validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Confirmar contraseña'),
                      obscureText: true,
                      onChanged: (value) => confirmPassword = value,
                    ),
                    const SizedBox(height: 16),
                    const Text('Selecciona tu rol:'),
                    RadioListTile(
                      title: const Text('Cliente'),
                      value: 'cliente',
                      groupValue: role,
                      onChanged: (value) => setState(() => role = value!),
                    ),
                    RadioListTile(
                      title: const Text('Restaurante'),
                      value: 'restaurante',
                      groupValue: role,
                      onChanged: (value) => setState(() => role = value!),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: registerUser,
                      child: const Text('Registrarse'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}