import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'package:qrcode_bloc/routes/router_name.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailC =
      TextEditingController(text: "admin1@gmail.com");
  TextEditingController passC = TextEditingController(text: "admin1");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autocorrect: false,
              obscureText: true,
              controller: passC,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogin(
                        email: emailC.text, password: passC.text));
                  },
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthStateLogin) {
                        context.goNamed(AppRoute.homePage);
                      }
                      if (state is AuthStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 3),
                            content: Text(state.error)));
                      }
                    },
                    // bloc: AuthBloc(),
                    builder: (context, state) {
                      log(state.toString());
                      if (state is AuthStateLoading) {
                        return const Text('Loading...');
                      } else {
                        return const Text('Login');
                      }
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
