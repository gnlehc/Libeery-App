import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:
            const EdgeInsets.only(top: 0, left: Spacing.large, right: Spacing.large, bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Acara",
                      style:
                        TextStyle(fontWeight: FontWeights.bold, fontSize: FontSizes.title),
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
                                  fontWeight: FontWeights.bold,
                                  fontSize: FontSizes.medium,
                                  color: AppColors.blue))),
                      const SizedBox(width: Spacing.small),
                      Text(
                        "Page: $page",
                        style: const TextStyle(
                          fontWeight: FontWeights.regular,
                          fontSize: FontSizes.description,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: Spacing.small),
                      GestureDetector(
                          onTap: () {
                            incrementPage();
                          },
                          child: const Text(">",
                              style: TextStyle(
                                  fontWeight: FontWeights.bold,
                                  fontSize: FontSizes.medium,
                                  color: AppColors.blue))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Spacing.medium),
              AcaraListAcaraPageWidget(page: page)
            ],
          ),
        ),
      ),
    );
  }
}
