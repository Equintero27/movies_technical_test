import 'package:flutter/material.dart';
import 'package:movie_technical_test/app/app.dart';
import 'package:movie_technical_test/features/auth/presentation/screens/login_screen.dart';
import 'package:movie_technical_test/features/profile/domain/entities/user_entity.dart';

class ProfileScreen extends StatefulWidget{
    const ProfileScreen({super.key});

    @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

  class _ProfileScreenState extends State<ProfileScreen>{

    ThemeMode _themeMode = ThemeMode.system;

    final UserEntity user = UserEntity(
        name: "Eimy Quintero",
        email: "eimydayana_11@hotmail.com",
        avatar: "",
    );

    void changeTheme(ThemeMode mode){
        setState((){
            _themeMode = mode;
        });
    }

    @override
    Widget build(BuildContext context){
        final themeMode = MyApp.of(context)!.themeMode;
        return Scaffold(
            appBar: AppBar(
                title: const Text("Perfil"),
            ),
            body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                    
                    ListTile(
                        leading: const CircleAvatar(
                            child: Icon(Icons.person),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "Tema de la aplicación",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    RadioListTile<ThemeMode>(
                        title: const Text("Tema automático"),
                        value: ThemeMode.system,
                        groupValue: themeMode,
                        onChanged: (value){
                            MyApp.of(context)?.changeTheme(value!);
                            setState(() {});
                        },
                    ),
                    RadioListTile<ThemeMode>(
                        title: const Text("Modo claro"),
                        value: ThemeMode.light,
                        groupValue: themeMode,
                        onChanged: (value){
                            MyApp.of(context)?.changeTheme(value!);
                            setState(() {});
                        },
                    ),
                    RadioListTile<ThemeMode>(
                        title: const Text("Modo oscuro"),
                        value: ThemeMode.dark,
                        groupValue: themeMode,
                        onChanged: (value){
                            MyApp.of(context)?.changeTheme(value!);
                            setState(() {});
                        },
                    ),
                    const Divider(),
                    
                    ListTile(
                        leading: const Icon(Icons.logout),
                        title: Text("Cerrar sesión"),
                        onTap: (){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                    ),
                                    (route) => false,
                            );
                        },
                    ),
                    const Center(
                        child: Text(
                            "Version 1.0.0",
                            style: TextStyle(color: Colors.grey),
                        ),
                    ),
                ],
            ),
        );
    }
  }