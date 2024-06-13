import 'package:flutter/material.dart';
import 'package:libeery/models/msbooks_model.dart';
import 'package:libeery/pages/book_detail_page.dart';
import 'package:libeery/styles/style.dart';

class BookList extends StatelessWidget {
  final List<MsBook> filteredBooks;

  const BookList({Key? key, required this.filteredBooks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.medium), 
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(), 
          shrinkWrap: true,
          itemCount: filteredBooks.length,
          itemBuilder: (context, index) {
             
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
              child: Card(
                elevation: 1.0,
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
                          padding: const EdgeInsets.fromLTRB(Spacing.small, 5.0, Spacing.small, 5.0),
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
                              fontSize: FontSizes.medium,
                              fontWeight: FontWeights.medium,
                              color: AppColors.black
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            filteredBooks[index].author,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: FontSizes.description,
                              fontWeight: FontWeights.regular,
                              color: AppColors.black
                            ),
                          ),
                          Text(
                            '${filteredBooks[index].edition}, ${filteredBooks[index].year}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 10.0,
                              fontWeight: FontWeights.regular,
                              color: Colors.black
                            ),
                          ),
                          Flexible(
                            child: Text(
                              filteredBooks[index].publisher,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 10.0,
                                fontWeight: FontWeights.regular,
                                color: Colors.black,
                                
                              ),
                            ),
                          ),
                          Text(
                            filteredBooks[index].stock > 0 ? 'Tersedia' : 'Tidak Tersedia',
                            style:  TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: FontSizes.description,
                              fontWeight: FontWeights.medium,
                              color: filteredBooks[index].stock > 0 ? AppColors.green : AppColors.red,
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
                        iconSize: FontSizes.subtitle,
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