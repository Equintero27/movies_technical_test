import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final user = TextEditingController();
  final password = TextEditingController();

  final passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~/]).{8,}$');

  bool obscurePassword = true; // 👈 NUEVO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Text(
                  "Movie Technical Test",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                TextFormField(
                  controller: user,
                  decoration:
                      const InputDecoration(labelText: "Usuario"),
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? "Por favor ingrese un valor"
                          : null,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: password,
                  obscureText: obscurePassword, // 👈 CAMBIO
                  decoration: InputDecoration(
                    labelText: "Contraseña",

                    // 👁️ icono mostrar/ocultar
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese un valor";
                    }

                    if (!passwordRegex.hasMatch(value)) {
                      return "Ingrese mínimo 8 caracteres, 1 número, 1 letra mayúscula\ny un caracter especial";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go('/home');
                    }
                  },
                  child: const Text("Ingresar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}