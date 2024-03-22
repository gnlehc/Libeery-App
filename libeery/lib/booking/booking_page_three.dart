import 'package:flutter/material.dart';

void main(){
  runApp(BookingPage3());
}

class Loker{
  bool dipilih;
  Color color;

  Loker
  (
    {
      required this.dipilih, required this.color
    }
  );
}

class BookingPage3 extends StatefulWidget {
  const BookingPage3({super.key});

  @override
  BookingPage3State createState() => BookingPage3State();
}

class BookingPage3State extends State<BookingPage3> {
  List<List<Loker>> lokerUser = List.generate(
    5,
    (index) => List.generate(
      5 * 12,
      (index) => Loker(dipilih: false, color: const Color(0xff5EC762)),
    ),
  );

  bool lokerDipilih = false;
  bool levelDipilih = false;
  int selectedColumn = -1;
  int selectedRow = -1;
  int selectedLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: const Column(
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
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: const Row(
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
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: List.generate(
                          5, 
                          (index) => GestureDetector(
                            onTap: (){
                              setState((){
                                selectedLevel = index;
                                levelDipilih = false;
                              });
                            },
                            child: Container(
                              height: 120,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: selectedLevel == index ? const Color(0xffF18700) : const Color.fromARGB(255, 224, 224, 224),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "${index+1}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: selectedLevel == index ? const Color(0xffF1F1F1) : const Color(0xff333333),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GridView.count(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          60,
                          (index) {
                            int row = index ~/ 12;
                            int column = index % 12;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (int i = 0; i < lokerUser.length; i++) {
                                    for (int j = 0; j < lokerUser[i].length; j++) {
                                      lokerUser[i][j].color = const Color(0xff5EC762);
                                    }
                                  }

                                  if (lokerUser[row][column].color == const Color(0xff5EC762)) {
                                    lokerUser[row][column].color = const Color(0xff0097DA);
                                  } else {
                                    lokerUser[row][column].color = const Color(0xff5EC762);
                                  }

                                  selectedColumn = column+1;
                                  selectedRow = row;
                                  if(selectedColumn >= 10){
                                    selectedColumn -= 10;
                                    selectedRow += 1;
                                  }
                                });
                              },
                              
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: lokerUser[row][column].color,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    const Text("Loker yang dipilih"),
                    if (selectedLevel != -1 && selectedRow != -1 && selectedColumn != -1)
                    Text(
                      "${(selectedLevel+1).toString()} - ${selectedRow.toString() + selectedColumn.toString()}", 
                      style: const TextStyle(
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ]
                ),
                const Divider(
                  thickness: 1.0,
                  color: Color(0xff333333),
                )
              ]
            ),
          ),

          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: (){}, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF18700),
                    fixedSize: const Size(134, 20),
                  ),
                  child: const Text(
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
  const AvailabilityInfo({
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
        const SizedBox(width: 5),
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
