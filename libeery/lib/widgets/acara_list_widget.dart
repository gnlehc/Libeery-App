import 'package:flutter/material.dart';
import 'package:libeery/models/msacara_model.dart';
import 'package:libeery/services/msacara_service.dart';
import 'package:libeery/widgets/acara_card_widget.dart';

class AcaraListAcaraPageWidget extends StatelessWidget {
  final int page;
  const AcaraListAcaraPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetListAcara>(
      future: MsAcaraServices.getAcaraForAcaraPage(page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.60,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return AcaraCard(acara: snapshot.data!.data![index]);
            },
          );
        }
      },
    );
  }
}
