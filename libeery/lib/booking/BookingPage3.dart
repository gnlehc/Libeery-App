import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(){
  BookingPage3();
}

class BookingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            height: 20,
            color: Colors.indigo,
            padding: EdgeInsets.symmetric(horizontal: 25),
          ),

          Container(
            height: 130,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pilih Lokermu!", 
                  style: TextStyle(
                    fontSize: 25, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Pilih loker yang ingin kamu tempati selama mengunjungi LKC Binus. Warna hijau berarti loker dapat kamu pilih sedangkan warna merah sebaliknya.", 
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AvailabilityInfo(
                  information: "Tersedia",
                  colorInfo: Color(0xff5EC762),
                ),
                AvailabilityInfo(
                  information: "Tidak Tersedia",
                  colorInfo: Color(0xffC75E5E),
                ),
                AvailabilityInfo(
                  information: "Pilihanmu",
                  colorInfo: Color(0xff0097DA),
                ),
              ],
            ),
          ),

          Container(
            height: 450,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  Container(
                    width: 180,
                    child: GridView.count(
                      padding: EdgeInsets.only(top: 10),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        12 * 5,
                        (index) => Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(0xff5EC762),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Container(
                            height: 180, // Fixed height for the SingleChildScrollView
                            padding: EdgeInsets.only(left: 20),
                            child: GridView.count(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              crossAxisCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                15 * 5,
                                (index) => Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Color(0xff5EC762),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 200, // Fixed height for the SingleChildScrollView
                            padding: EdgeInsets.only(top: 40, left: 60),
                            child: GridView.count(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              crossAxisCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                15 * 5,
                                (index) => Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Color(0xff5EC762),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 220, // Fixed height for the SingleChildScrollView
                            padding: EdgeInsets.only(top: 40, left: 20),
                            child: GridView.count(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              crossAxisCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                15 * 5,
                                (index) => Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Color(0xff5EC762),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text("Loker yang dipilih"),
                Text(
                  "213", 
                  style: TextStyle(
                    fontWeight: FontWeight.w700
                  ),
                )
              ]
            )
          ),

          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: (){}, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF18700),
                    fixedSize: Size(134, 20),
                  ),
                  child: Text(
                    "Selanjutnya", 
                    style: TextStyle(
                      color: Color(0xffF1F1F1)
                    )
                  )
                ),
                TextButton(
                  onPressed: (){}, 
                  child: Text(
                    "Sebelumnya...", 
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      decoration: TextDecoration.underline
                    )
                  )
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}

class AvailabilityInfo extends StatelessWidget {
  AvailabilityInfo({
    super.key,
    required this.information,
    required this.colorInfo,
  });

  final Color colorInfo;
  final String information;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: colorInfo,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 5),
        Text(
          information, 
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorInfo,
          ),
        ),
      ],
    );
  }
}
