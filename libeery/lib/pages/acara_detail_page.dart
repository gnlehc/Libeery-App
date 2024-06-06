import 'package:flutter/material.dart';
import 'package:libeery/models/msacara_model.dart';
import 'package:libeery/services/msacara_service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
          padding: const EdgeInsets.only(top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 15,
                ),
              ),
              const Text(
                'Tentang Acara',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.black,
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
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.center,
                      child: Image.network(acara.acaraImage),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'WEBINAR',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Color.fromRGBO(241, 135, 0, 1),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              acara.acaraName,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 19.0,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 10.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text(
                        'TIME & DATE',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Color.fromRGBO(241, 135, 0, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.access_time),
                            iconSize: 25,
                            color: Colors.blue,
                          ),
                          Text(
                            '${DateFormat('HH:mm').format(acara.acaraStartTime)} - ${DateFormat('HH:mm').format(acara.acaraEndTime)}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 30.0),
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.date_range),
                            iconSize: 25,
                            color: Colors.blue,
                          ),
                          Text(
                            dateFormat.format(acara.acaraDate),
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text(
                        'SPEAKER',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Color.fromRGBO(241, 135, 0, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.person_outlined),
                            iconSize: 25,
                            color: Colors.blue,
                          ),
                          Text(
                            acara.speakerName,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text(
                        'LOCATION',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          color: Color.fromRGBO(241, 135, 0, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            alignment: Alignment.topCenter,
                            onPressed: () {},
                            icon: const Icon(Icons.location_on_outlined),
                            iconSize: 25,
                            color: Colors.blue,
                          ),
                          Text(
                            acara.acaraLocation,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Column(
                        children: [
                          Text(
                            'EVENT DETAILS',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: Color.fromRGBO(241, 135, 0, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 20.0),
                      child: Text(
                        acara.acaraDetails,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFFF18700), Color(0xFFF8C17B)],
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
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          child: const Text(
                            'Join Here',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0)
                  ],
                ),
              );
            }
          }),
    );
  }
}
