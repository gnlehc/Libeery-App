
import 'package:flutter/material.dart';
import 'package:libeery/models/msbooks_model.dart';
import 'package:libeery/services/msbooks_service.dart';

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
        backgroundColor: const Color.fromRGBO(51, 51, 51, 1),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(51, 51, 51, 1),
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 15,
                        color: Colors.white,
                      ),
                      const Text(
                        'Informasi Buku',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              ),
          ),
          Positioned(
            top: 170.0, 
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height, 
                
              ),
            ),
          ),
          Positioned(
            top: 75.0,
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
            top: 280.0,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            book.title,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0
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
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start, 
                                children: [
                                  Text(
                                    book.year.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                    ),
                                  ),
                                  const SizedBox(height: 3.0),
                                  const Text(
                                    'Tahun Rilis',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
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
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                    ),
                                  ),
                                  const SizedBox(height: 3.0),
                                  const Text(
                                    'ISBN',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
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
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: book.stock > 0 ? Colors.green : Colors.red,
                                    ),
                                  ),
                                  const SizedBox(height: 3.0),
                                  const Text(
                                    'Ketersediaan',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                              'Abstract',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              book.abstract,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 11.0,
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






