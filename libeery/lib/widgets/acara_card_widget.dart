import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libeery/models/msacara_model.dart';
import 'package:libeery/pages/acara_detail_page.dart';
import 'package:libeery/styles/style.dart';
import 'package:url_launcher/url_launcher.dart';

class AcaraCard extends StatelessWidget {
  final MsAcara acara;

  const AcaraCard({Key? key, required this.acara}) : super(key: key);

  _launchGoogleForm() async {
    final Uri url = Uri.parse(acara.registerLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('d MMMM yyyy', 'id');
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardWidth = deviceWidth * 0.55;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AcaraDetailPage(id: acara.acaraID)),
        );
      },
      child: Container(
        width: cardWidth,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 75.0,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10.0)),
                image: DecorationImage(
                  image: NetworkImage(acara.acaraImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("SEMINAR",
                      style: TextStyle(
                          color: AppColors.orange,
                          fontSize: FontSizes.description,
                          fontWeight: FontWeights.medium)),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    width: cardWidth * 0.6,
                    child: Text(
                      acara.acaraName,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: FontSizes.description,
                        fontWeight: FontWeights.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                  const SizedBox(height: Spacing.small),
                  const Text("TIME & DATE",
                      style: TextStyle(
                          color: AppColors.orange,
                          fontSize: FontSizes.description,
                          fontWeight: FontWeights.medium)),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const Icon(Icons.date_range,
                          color: AppColors.blue, size: FontSizes.description),
                      const SizedBox(width: 5.0),
                      Text(dateFormat.format(acara.acaraDate),
                          // formatDateTime(acara.acaraDate.toString()),
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: FontSizes.description,
                              fontWeight: FontWeights.medium)),
                    ],
                  ),
                  const SizedBox(height: Spacing.small),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: Color(0xFF0097DA), size: FontSizes.description),
                      const SizedBox(width: 5.0),
                      Text(
                          formatTimeRange(acara.acaraStartTime.toString(),
                              acara.acaraEndTime.toString()),
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: FontSizes.description,
                              fontWeight: FontWeights.medium)),
                    ],
                  ),
                  const SizedBox(height: Spacing.medium),
                  Center(
                    child: GestureDetector(
                      onTap: _launchGoogleForm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [AppColors.orange, Color(0xFFF8C17B)],
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'Join here',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: FontSizes.description,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeights.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dateTime);
  }

  String formatTimeRange(String startTimeString, String endTimeString) {
    DateTime startTime = DateTime.parse(startTimeString);
    DateTime endTime = DateTime.parse(endTimeString);
    String formattedStartTime = DateFormat.Hm().format(startTime);
    String formattedEndTime = DateFormat.Hm().format(endTime);
    return 'Pukul $formattedStartTime - $formattedEndTime';
  }
}
