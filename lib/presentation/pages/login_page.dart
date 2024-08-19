import 'package:agenda_mobile/bloc/login/login_bloc.dart';
import 'package:agenda_mobile/data/models/request/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Welcome, ${state.response.user.name}!')),
                  );
                  // Navigate to another screen or perform other actions
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final loginRequest = LoginRequestModel(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    context
                        .read<LoginBloc>()
                        .add(ProsesLoginEvent(request: loginRequest));
                  },
                  child: const Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
