import 'package:flutter/material.dart';
import 'package:libeery/models/msbooks_model.dart';
import 'package:libeery/services/msbooks_service.dart';
import 'package:libeery/pages/home_page.dart';
import 'package:libeery/widgets/list_books_widget.dart';
import 'package:libeery/widgets/navbar_widget.dart';

class BooksPage extends StatefulWidget {
  final String? userId;
  final String? username;
  final int selectedIndex;

  const BooksPage({Key? key, required this.userId, required this.username, required this.selectedIndex}) : super(key: key);
  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<MsBook> booksData = []; 
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
            userId: widget.userId,
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
        booksData = booksData.where((item) =>
          item.title.toLowerCase().contains(query.toLowerCase()) ||
          item.author.toLowerCase().contains(query.toLowerCase()) ||
          item.isbn.toLowerCase().contains(query.toLowerCase()) ||
          item.publisher.toLowerCase().contains(query.toLowerCase()) ||
          item.edition.toLowerCase().contains(query.toLowerCase()) ||
          item.year.toString().contains(query)).toList();
      });
    } else {
      setState(() {
        getBooks();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                color: const Color(0xFF333333),
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Cari Buku",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Text(
                      "Carilah ketersediaan buku yang ingin kamu baca atau pinjam di LKC dengan mengetikkan informasi detil buku tersebut.",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          borderSide: BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Color(0xFF0097DA), width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        hintStyle: TextStyle(color: Color(0xFF7E7E7E), fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          BookList(filteredBooks: booksData),
        ],
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}