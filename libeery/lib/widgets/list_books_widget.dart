import 'package:flutter/material.dart';
import 'package:libeery/models/msbooks_model.dart';
import 'package:libeery/pages/book_detail_page.dart';

class BookList extends StatelessWidget {
  final List<MsBook> filteredBooks;

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
             
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Card(
                elevation: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromRGBO(109, 109, 109, 0.1),
                      width: 1.0
                    )
                  ),
                  width: double.infinity,
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 2.0, 19.0, 2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              filteredBooks[index].photo,
                              height: 100,
                              width: 75,
                              fit: BoxFit.cover,
                              
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            filteredBooks[index].title,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            filteredBooks[index].author,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 9.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                            ),
                          ),
                          Text(
                            '${filteredBooks[index].edition}, ${filteredBooks[index].year}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 9.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                            ),
                          ),
                          Flexible(
                            child: Text(
                              filteredBooks[index].publisher,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 9.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                
                              ),
                            ),
                          ),
                          Text(
                            filteredBooks[index].stock > 0 ? 'Tersedia' : 'Tidak Tersedia',
                            style:  TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 9.5,
                              fontWeight: FontWeight.w400,
                              color: filteredBooks[index].stock > 0 ? Colors.green : Colors.red,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>   BookDetailPage(bookID: filteredBooks[index].bookID)));
                        }, 
                        icon: const Icon(Icons.chevron_right),
                        iconSize: 12,
                        alignment: Alignment.bottomRight,
                        ),
                      ),
                    ],
                  ),
                ),
                ),
            );
          },
        ),
      ),
    );
  }
}