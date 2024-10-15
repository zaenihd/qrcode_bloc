import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode_bloc/routes/router_name.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('Product Page'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text("${index + 1}"),
              ),
              onTap: () {
                context.goNamed(
                  AppRoute.detailProduct,
                  queryParameters: {"id": "${index + 1}"},
                );

                //
              },
              title: Text("Products ${index + 1}"),
            );
          },
        ));
  }
}
