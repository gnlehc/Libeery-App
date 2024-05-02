import 'package:flutter/material.dart';

class AcaraCard extends StatelessWidget {
  const AcaraCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Judul"),
          Text("Description"),
          Text("Isi"),
        ],
      ),
    );
  }
}
