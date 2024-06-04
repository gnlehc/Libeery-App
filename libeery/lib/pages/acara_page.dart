import 'package:flutter/material.dart';
import 'package:libeery/widgets/acara_list_widget.dart';

class AcaraPage extends StatefulWidget {
  const AcaraPage({super.key});

  @override
  State<AcaraPage> createState() => _AcaraPageState();
}

class _AcaraPageState extends State<AcaraPage> {
  late int page = 1;

  void incrementPage() {
    setState(() {
      page++;
    });
  }

  void decrementPage() {
    if (page > 1) {
      setState(() {
        page--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: const Image(
          image: AssetImage('assets/image/whitebackground.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 4, left: 30, right: 30, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Acara",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            print("Back clicked");
                            print(page);
                            if (page > 1) {
                              decrementPage();
                            }
                          },
                          child: const Text("<",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black26))),
                      const SizedBox(width: 4),
                      Text(
                        "Page: $page",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black26,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                          onTap: () {
                            incrementPage();
                          },
                          child: const Text(">",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black26))),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              AcaraListAcaraPageWidget(page: page)
            ],
          ),
        ),
      ),
    );
  }
}
