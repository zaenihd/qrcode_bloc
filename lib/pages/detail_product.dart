import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'package:qrcode_bloc/bloc/product/product_bloc.dart';
import 'package:qrcode_bloc/model/product_model.dart';
import 'package:qrcode_bloc/routes/router_name.dart';

class DetailProductPage extends StatelessWidget {
  DetailProductPage({required this.products, super.key});

  final ProductModel products;
  TextEditingController namaC = TextEditingController();
  TextEditingController codeC = TextEditingController();
  TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    namaC.text = products.name!;
    qtyC.text = "${products.qty!}";
    codeC.text = products.code!;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('Detail Products Page'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: QrImageView(
                  size: 200,
                  data: products.code!,
                  version: QrVersions.auto,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Kode Product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autocorrect: false,
              readOnly: true,
              controller: codeC,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Nama Product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autocorrect: false,
              controller: namaC,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autocorrect: false,
              controller: qtyC,
            ),
            const SizedBox(
              height: 20.0,
            ),
            _editButton(context),
            const SizedBox(
              height: 10.0,
            ),
            _deleteButton(context)
          ],
        ));
  }

  TextButton _deleteButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          context
              .read<ProductBloc>()
              .add(ProductEventDeleteProduct(id: products.productId!));
        },
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(state.message)));
            }
            if (state is ProductDeleted) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 3),
                  content: Text("Berhasil Hapus Product")));
            }
          },
          builder: (context, state) {
            return Text(
              state is ProductLoadingUpdate ? "Loading..." : 'Delete Product',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            );
          },
        ));
  }

  SizedBox _editButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
          onPressed: () {
            context.read<ProductBloc>().add(ProductEventEditProduct(
                name: namaC.text,
                productId: products.productId!,
                qty: int.tryParse(qtyC.text) ?? 0));
          },
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 3),
                    content: Text(state.message)));
              }
              if (state is ProductEdited) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text("Berhasil Edit Product")));
              }
            },
            builder: (context, state) {
              return Text(
                state is ProductLoadingDelete ? "Loading..." : 'Edit Product',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              );
            },
          )),
    );
  }
}
