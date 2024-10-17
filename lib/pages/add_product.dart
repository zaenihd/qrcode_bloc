import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'package:qrcode_bloc/bloc/product/product_bloc.dart';
import 'package:qrcode_bloc/routes/router.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});

  TextEditingController kodeC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController quantityC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Page'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              autocorrect: false,
              controller: kodeC,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  labelText: "Kode Product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Nama Product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autocorrect: false,
              controller: nameC,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Quantity Product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              autocorrect: false,
              controller: quantityC,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    if (kodeC.text.length == 10) {
                      context.read<ProductBloc>().add(ProductEventAddProduct(
                          name: nameC.text,
                          code: kodeC.text,
                          qty: int.tryParse(quantityC.text) ?? 0));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text("Code Product Wajib 10 karakter")));
                    }
                  },
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is ProductError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 3),
                            content: Text(state.message)));
                      }
                      if (state is ProductUploaded) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text("Berhasil Upload Product")));
                      }
                    },
                    builder: (context, state) {
                      return Text(
                        state is ProductLoading
                            ? "Loading..."
                            : 'Tambah Product',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
