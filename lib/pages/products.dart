import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_bloc/bloc/auth/auth_bloc.dart';
import 'package:qrcode_bloc/bloc/product/product_bloc.dart';
import 'package:qrcode_bloc/model/product_model.dart';
import 'package:qrcode_bloc/routes/router_name.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('Product Page'),
        ),
        body: StreamBuilder<QuerySnapshot<ProductModel>>(
          stream: productBloc.streamProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text("No Data"),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }

            List<ProductModel> listProduct = [];

            for (var element in snapshot.data!.docs) {
              listProduct.add(element.data());
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: listProduct.length,
              itemBuilder: (context, index) {
                final products = listProduct[index];
                return InkWell(
                  onTap: () {
                    context.goNamed(AppRoute.detailProduct, extra: products);
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Row(
                        children: [
                           Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${products.name}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Text("code : ${products.code}"),
                                Text("qty : ${products.qty} pcs"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: QrImageView(
                              size: 200,
                              data: products.code!,
                              version: QrVersions.auto,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
