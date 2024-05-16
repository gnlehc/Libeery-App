import 'package:flutter/material.dart';
import 'package:libeery/models/msacara_model.dart';
import 'package:libeery/services/msacara_service.dart';
import 'package:libeery/widgets/acara_card_widget.dart';

class AcaraListWidget extends StatelessWidget {
  const AcaraListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetListAcara>(
      future: MsAcaraServices.getAcaraForHomePage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < snapshot.data!.data!.length; i += 2)
                    AcaraCard(acara: snapshot.data!.data![i]),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 1; i < snapshot.data!.data!.length; i += 2)
                    AcaraCard(acara: snapshot.data!.data![i]),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
