import 'package:flutter/material.dart';
import 'package:libeery/models/book_model.dart';

class BookList extends StatelessWidget {
  final List<Book> filteredBooks;

  const BookList({Key? key, required this.filteredBooks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), 
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(), 
          shrinkWrap: true,
          itemCount: filteredBooks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredBooks[index].title),
              subtitle: Text("${filteredBooks[index].author} - ${filteredBooks[index].year}"),
            );
          },
        ),
      ),
    );
  }
}