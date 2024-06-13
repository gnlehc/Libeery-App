
import 'package:flutter/material.dart';
import 'package:libeery/models/msbooks_model.dart';
import 'package:libeery/services/msbooks_service.dart';
import 'package:libeery/styles/style.dart';

class BookDetailPage extends StatefulWidget {
  final int bookID;
  const BookDetailPage({Key? key, required this.bookID}) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Future<MsBook> bookDetail;

  @override
  void initState() {
    super.initState();
    bookDetail = BookService.fetchBookDetails(widget.bookID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.black,
        title: Padding(
          padding: const EdgeInsets.only(top: Spacing.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: FontSizes.subtitle,
                  color: AppColors.white,
                ),
              ),
              const Text(
                'Informasi Buku',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeights.bold,
                  fontSize: FontSizes.subtitle,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.black,
            height: double.infinity,
          ),
          Positioned(
            top: 120.0, 
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                color: AppColors.white,
                height: MediaQuery.of(context).size.height, 
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 0,
            right: 0,
            child: FutureBuilder<MsBook>(
              future: bookDetail,
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final book = snapshot.data!;
                return Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      book.photo,
                      width: 116,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              }
            )
            ),
           Positioned(
            top: 230.0,
            left: 0,
            right: 0,
            child:  FutureBuilder<MsBook>(
              future: bookDetail,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final book = snapshot.data!;
                return  SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            book.title,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeights.bold,
                              fontSize: FontSizes.subtitle,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Center(
                          child: Text(
                            book.author,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                                fontWeight: FontWeights.medium,
                                fontSize: FontSizes.description,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: Spacing.large),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start, 
                                  children: [
                                    Text(
                                      book.year.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: FontSizes.description,
                                        fontWeight: FontWeights.bold,
                                        color: Colors.black
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    const Text(
                                      'Tahun Rilis',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: FontSizes.description,
                                        fontWeight: FontWeights.regular,
                                        color: Colors.black
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start, 
                                  children: [
                                    Text(
                                      book.isbn,
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: FontSizes.description,
                                        fontWeight: FontWeights.bold,
                                        color: Colors.black
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    const Text(
                                      'ISBN',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: FontSizes.description,
                                        fontWeight: FontWeights.regular,
                                        color: Colors.black
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start, 
                                  children: [
                                    Text(
                                      book.stock > 0 ? 'Tersedia' : 'Tidak Tersedia',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: FontSizes.description,
                                        fontWeight: FontWeights.bold,
                                        color: book.stock > 0 ? Colors.green : Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    const Text(
                                      'Ketersediaan',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: FontSizes.description,
                                        fontWeight: FontWeights.regular,
                                        color: Colors.black
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Spacing.large),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                              'Abstract',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: FontSizes.medium,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              book.abstract,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: FontSizes.medium,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }
            )
          ),
        ],
      ),
    );
  }
}






