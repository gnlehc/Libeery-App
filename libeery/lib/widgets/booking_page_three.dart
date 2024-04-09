import 'package:flutter/material.dart';
import 'package:libeery/models/loker.dart';
import 'package:libeery/services/loker_service.dart';

void main(){
  runApp(const BookingPage3());
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
  List<dynamic> listLoker = [];

  void getLoker() async{
    try {
      final List<dynamic> result = await LokerService.getLoker();
      setState(() {
        listLoker = result;
      });
    } catch (e) {
      e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getLoker();
  }

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

  void updateSelectedLocker(int rowIndex, int columnIndex) {
    setState(() {

      // Check locker's availability
      final MsLoker selectedLoker = listLoker.firstWhere(
        (element) =>
            element.rowNumber == rowIndex + 1 &&
            element.columnNumber == columnIndex + 1,
        orElse: () => MsLoker(
          lockerID: 0, 
          rowNumber: 0, 
          columnNumber: 0, 
          availability: 'Active', 
          stsrc: ''
        ),
      );

      // if booked, return because the color already set to be red
      if (selectedLoker.availability == 'Booked') {
        return;
      }

      // Reselect to other locker
      if (selectedRow == rowIndex && selectedColumn == columnIndex) {
        lokerUser[rowIndex][columnIndex].dipilih = false;
        lokerUser[rowIndex][columnIndex].color = const Color(0xff5EC762); // Available color
        selectedRow = -1;
        selectedColumn = -1;
      } else {
        // Deselect locker
        if (selectedRow != -1 && selectedColumn != -1) {
          lokerUser[selectedRow][selectedColumn].dipilih = false;
          lokerUser[selectedRow][selectedColumn].color = const Color(0xff5EC762); // Available color
        }

        // Selecting any locker available
        lokerUser[rowIndex][columnIndex].dipilih = true;
        lokerUser[rowIndex][columnIndex].color = const Color(0xff0097DA); // Selected color
        selectedRow = rowIndex;
        selectedColumn = columnIndex;
      }
    });
  }


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
          
          SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  const SizedBox(
                    height: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RowInfo(text: "1"),
                        RowInfo(text: "2"),
                        RowInfo(text: "3"),
                        RowInfo(text: "4"),
                        RowInfo(text: "5")
                      ],
                    )
                  ),
                  
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 60,
                      itemBuilder: (context, columnIndex) {
                        return Column(
                          children: List.generate(5, (rowIndex) {
                            final MsLoker loker = listLoker.firstWhere(
                              (element) =>
                                  element.rowNumber == rowIndex + 1 &&
                                  element.columnNumber == columnIndex + 1,
                              orElse: () => MsLoker(
                                lockerID: 0, 
                                rowNumber: 0, 
                                columnNumber: 0, 
                                availability: 'Active', 
                                stsrc: ''
                              ),
                            );

                            Color color;
                            if (loker.availability == 'Booked') {
                              color = const Color(0xffC75E5E);
                            } else {
                              if (lokerUser[rowIndex][columnIndex].dipilih) {
                                color = const Color(0xff0097DA);
                              } else {
                                color = const Color(0xff5EC762);
                              }
                            }

                            return GestureDetector(
                              onTap: (){
                                updateSelectedLocker(rowIndex, columnIndex);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.5, left: 10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: color,
                                ),
                              )
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              )
            ),
          ),
          
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical:10, horizontal: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    const Text("Loker yang dipilih"),
                    if (selectedRow != -1 && selectedColumn != -1)
                    Text(
                      listLoker.firstWhere((loker) =>
                        loker.rowNumber == selectedRow + 1 &&
                        loker.columnNumber == selectedColumn + 1).lockerID.toString(),
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

class RowInfo extends StatelessWidget{
  const RowInfo({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context){
    return Text(
      text, 
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xff333333),
      )
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