import 'package:flutter/material.dart';
import 'package:libeery/models/msacara_model.dart';
import 'package:libeery/services/msacara_service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:libeery/styles/style.dart';

class AcaraDetailPage extends StatefulWidget {
  final int id;
  const AcaraDetailPage({super.key, required this.id});

  @override
  State<AcaraDetailPage> createState() => _AcaraDetailPage();
}

class _AcaraDetailPage extends State<AcaraDetailPage> {
  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('EEEE, d MMMM yyyy', 'id');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const Image(
          image: AssetImage('assets/image/whitebackground.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: Spacing.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: Spacing.small),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: FontSizes.subtitle,
                ),
              ),
              const Text(
                'Tentang Acara',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeights.medium,
                  fontSize: FontSizes.subtitle,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<MsAcara>(
          future: MsAcaraServices.fetchAcaraDetails(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final acara = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Spacing.small),
                    Align(
                      alignment: Alignment.center,
                      child: Image.network(acara.acaraImage),
                    ),
                    const SizedBox(height: Spacing.medium),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(Spacing.large, 0, Spacing.large, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'WEBINAR',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeights.medium,
                                fontSize: FontSizes.medium,
                                color: AppColors.orange,
                              ),
                            ),
                            const SizedBox(height: Spacing.small),
                            Text(
                              acara.acaraName,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeights.bold,
                                fontSize: FontSizes.subtitle,
                                color: AppColors.black,
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(height: Spacing.small),
                    const Padding(
                      padding: EdgeInsets.only(left: Spacing.large),
                      child: Text(
                        'TIME & DATE',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeights.medium,
                          fontSize: FontSizes.medium,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: Spacing.medium),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.access_time),
                            iconSize: FontSizes.title,
                            color: AppColors.blue,
                          ),
                          Text(
                            '${DateFormat('HH:mm').format(acara.acaraStartTime)} - ${DateFormat('HH:mm').format(acara.acaraEndTime)}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeights.medium,
                              fontSize: FontSizes.description,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(width: Spacing.large),
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.date_range),
                            iconSize: FontSizes.title,
                            color: AppColors.blue,
                          ),
                          Text(
                            dateFormat.format(acara.acaraDate),
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeights.medium,
                              fontSize: FontSizes.description,
                              color: AppColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: Spacing.large),
                      child: Text(
                        'SPEAKER',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeights.medium,
                          fontSize: FontSizes.medium,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: Spacing.medium),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.person_outlined),
                            iconSize: FontSizes.title,
                            color: AppColors.blue,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: RichText(
                                text: TextSpan(
                                  text: acara.speakerName,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeights.medium,
                                    fontSize: FontSizes.description,
                                    color: AppColors.black,
                                  ),
                                ),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: Spacing.large),
                      child: Text(
                        'LOCATION',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeights.medium,
                          fontSize: FontSizes.medium,
                          color:AppColors.orange,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: Spacing.medium),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.location_on_outlined),
                            iconSize: FontSizes.title,
                            color: AppColors.blue,
                          ),
                          Text(
                            acara.acaraLocation,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeights.medium,
                              fontSize: FontSizes.description,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: Spacing.large),
                      child: Column(
                        children: [
                          Text(
                            'EVENT DETAILS',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeights.medium,
                              fontSize: FontSizes.medium,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Spacing.small),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(Spacing.large, 0, Spacing.large, Spacing.medium),
                      child: Text(
                        acara.acaraDetails,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeights.medium,
                          fontSize: FontSizes.description,
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: Spacing.medium),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Spacing.medium),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Spacing.small),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [AppColors.orange, Color(0xFFF8C17B)],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _launchURL(acara.registerLink);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Spacing.small),
                              )),
                          child: const Text(
                            'Join Here',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: FontSizes.subtitle,
                                fontWeight: FontWeights.medium,
                                color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: Spacing.large)
                  ],
                ),
              );
            }
          }),
    );
  }
}
