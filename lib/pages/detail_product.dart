import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
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
      body:  Center(
        child: Text('Detail Products page ${data['id']}'),
      ),
    );
  }
}
