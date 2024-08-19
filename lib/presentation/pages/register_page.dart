import 'package:agenda_mobile/bloc/register/register_bloc.dart';
import 'package:agenda_mobile/data/models/request/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // add controller
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  // add state init
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: const [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: nameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'email'),
                controller: emailController,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'password'),
                controller: passwordController,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoaded) {
                    nameController!.clear();
                    emailController!.clear();
                    passwordController!.clear();
                    // navigasi ke login
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Register Berhasil')));

                    // Navigator.of(context).pushReplacementNamed('/login');
                  } else if (state is RegisterFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${state.error}')));
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      print('Name: ${nameController!.text}');
                      print('Email: ${emailController!.text}');
                      print('Password: ${passwordController!.text}');
                      final requestModel = RegisterModel(
                        name: nameController!.text,
                        email: emailController!.text,
                        password: passwordController!.text,
                      );

                      // Kirim ke RegisterBloc
                      context
                          .read<RegisterBloc>()
                          .add(SaveRegisterEvent(request: requestModel));
                    },
                    child: const Text('Register'),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
