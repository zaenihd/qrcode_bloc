import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'package:qrcode_bloc/bloc/product/product_bloc.dart';
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
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late Function() onTap;
          switch (index) {
            case 0:
              title = "Add Product";
              icon = Icons.post_add;
              onTap = () {
                context.goNamed(AppRoute.addProduct);
              };
              break;
            case 1:
              title = "Products";
              icon = Icons.list_alt;
              onTap = () {
                context.goNamed(AppRoute.productPage);
              };
              break;
            case 2:
              title = "QR code";
              icon = Icons.qr_code_2_outlined;
              onTap = () {};
              break;
            case 3:
              title = "Catalog";
              icon = Icons.document_scanner;
              onTap = () {
                context.read<ProductBloc>().add(ProductEventExportPdfProduct());
              };
              break;
          }

          return InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  index == 3
                      ? BlocConsumer<ProductBloc, ProductState>(
                          builder: (context, state) {
                            if (state is ProductLoadingExport) {
                              return const CircularProgressIndicator();
                            }
                            return Icon(
                              icon,
                              size: 50,
                            );
                          },
                          listener: (context, state) {},
                        )
                      : Icon(
                          icon,
                          size: 50,
                        ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(title)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
