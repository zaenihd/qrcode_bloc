import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'package:qrcode_bloc/bloc/product/product_bloc.dart';
import 'package:qrcode_bloc/routes/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
