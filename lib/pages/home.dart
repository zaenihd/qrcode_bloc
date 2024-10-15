import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'package:qrcode_bloc/routes/router_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // context.goNamed(AppRoute.productPage);
            context.read<AuthBloc>().add(AuthEventLogout());
          },
          child: const Icon(Icons.login)),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateLogout) {
                  context.goNamed(AppRoute.login);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is AuthStateLoading) {
                  return const CircularProgressIndicator();
                }
                return const Text("HOME PAGE");
              },
            ),
            const Text('data')
          ],
        ),
      ),
    );
  }
}
