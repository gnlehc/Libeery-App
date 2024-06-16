import 'package:flutter/material.dart';
import 'package:libeery/models/msbooks_model.dart';
import 'package:libeery/services/msbooks_service.dart';
import 'package:libeery/pages/home_page.dart';
import 'package:libeery/styles/style.dart';
import 'package:libeery/widgets/list_books_widget.dart';
import 'package:libeery/widgets/navbar_widget.dart';

class BooksPage extends StatefulWidget {
  final String? userId;
  final String? username;
  final int selectedIndex;

  const BooksPage(
      {Key? key,
      required this.userId,
      required this.username,
      required this.selectedIndex})
      : super(key: key);
  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<MsBook> booksData = [];
  List<MsBook> filteredBooks = [];
  TextEditingController editingController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    getBooks();
  }

  void getBooks() async {
    try {
      final BookService bookService = BookService();
      GetAllMsBookData result = await bookService.getBook();
      setState(() {
        booksData = result.data ?? [];
        filteredBooks = booksData;
      });
    } catch (e) {
      e.toString();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userId: widget.userId!,
            username: widget.username,
            selectedIndex: 0,
          ),
        ),
      );
    } else if (_selectedIndex == 1) {
      // stay on this page
    } else if (_selectedIndex == 2) {
      // Navigate to Profile Page
    }
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredBooks = booksData
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()) ||
                item.author.toLowerCase().contains(query.toLowerCase()) ||
                item.isbn.toLowerCase().contains(query.toLowerCase()) ||
                item.publisher.toLowerCase().contains(query.toLowerCase()) ||
                item.edition.toLowerCase().contains(query.toLowerCase()) ||
                item.year.toString().contains(query))
            .toList();
      });
    } else {
      setState(() {
        filteredBooks = booksData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.black,
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Cari Buku",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: AppColors.white,
                          fontSize: FontSizes.title,
                          fontWeight: FontWeights.bold),
                    ),
                    const Text(
                      "Carilah ketersediaan buku yang ingin kamu baca atau pinjam di LKC dengan mengetikkan informasi detil buku tersebut.",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: AppColors.white,
                        fontSize: FontSizes.medium,
                        fontWeight: FontWeights.light,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: Spacing.large),
                    TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: editingController,
                      decoration: const InputDecoration(
                        hintText: "Cari buku disini...",
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: AppColors.gray, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: AppColors.blue, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: Spacing.medium),
                        hintStyle: TextStyle(
                            color: AppColors.gray,
                            fontWeight: FontWeights.regular),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          BookList(filteredBooks: filteredBooks),
        ],
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
