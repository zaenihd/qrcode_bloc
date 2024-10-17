import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:qrcode_bloc/model/product_model.dart';
import 'package:pdf/widgets.dart' as pw;

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<ProductModel>> streamProduct() async* {
    yield* firestore
        .collection("products")
        .withConverter<ProductModel>(
            fromFirestore: (snapshot, _) =>
                ProductModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .snapshots();
  }

  ProductBloc() : super(ProductInitial()) {
    //========= ADD PRODUCT ===========

    on<ProductEventAddProduct>((event, emit) async {
      try {
        emit(ProductLoading());
        var hasil = await firestore.collection("products").add({
          "name": event.name,
          "code": event.code,
          "qty": event.qty,
        });

        await firestore
            .collection("products")
            .doc(hasil.id)
            .update({"productId": hasil.id});
        emit(ProductUploaded());
      } on FirebaseException catch (e) {
        emit(ProductError(message: "$e"));
      } catch (e) {
        emit(ProductError(message: "$e"));
      }
    });

    //========= DELETE PRODUCT ===========

    on<ProductEventDeleteProduct>((event, emit) async {
      try {
        emit(ProductLoadingDelete());
        await firestore.collection("products").doc(event.id).delete();
        emit(ProductDeleted());
      } on FirebaseException catch (e) {
        emit(ProductError(message: "$e"));
      } catch (e) {
        emit(ProductError(message: "$e"));
      }
    });

    //========= EDIT PRODUCT ===========
    on<ProductEventEditProduct>((event, emit) async {
      try {
        emit(ProductLoadingUpdate());
        await firestore.collection("products").doc(event.productId).update({
          "name": event.name,
          "qty": event.qty,
        });

        emit(ProductEdited());
      } on FirebaseException catch (e) {
        emit(ProductError(message: "$e"));
      } catch (e) {
        emit(ProductError(message: "$e"));
      }
    });

    //========= EXPORT PDF PRODUCT ===========
    on<ProductEventExportPdfProduct>((event, emit) async {
      try {
        emit(ProductLoadingExport());
        var querySnap = await firestore
            .collection("products")
            .withConverter<ProductModel>(
                fromFirestore: (snapshot, _) =>
                    ProductModel.fromJson(snapshot.data()!),
                toFirestore: (model, _) => model.toJson())
            .get();

        List<ProductModel> allProducts = [];
        for (var element in querySnap.docs) {
          allProducts.add(element.data());
        }

        //bikin pdf
        final pdf = pw.Document();
        var data = await rootBundle.load('assets/OpenSans_Condensed-Regular.ttf');
        var myFont = pw.Font.ttf(data);
        var myStyle = pw.TextStyle(font: myFont);
        pdf.addPage(pw.MultiPage(
            build: (context) {
              return [pw.Text("Hello", style: myStyle)];
            },
            pageFormat: PdfPageFormat.a4));

        //buka pdf
        Uint8List bytes = await pdf.save();
        final dir = await getApplicationDocumentsDirectory();
        File file = File("${dir.path}/myproducts.pdf");

        //masukin data byte ke pdf
        await file.writeAsBytes(bytes);

        await OpenFile.open(file.path);

        emit(ProductExported());
      } on FirebaseException catch (e) {
        emit(ProductError(message: "$e"));
      } catch (e) {
        emit(ProductError(message: "$e"));
      }
    });
  }
}
