
import 'package:flutter/material.dart';



void main() => runApp( const MaterialApp(
  home: BookForLater(),
));

class BookForLater extends StatefulWidget {
  const BookForLater({super.key});

  @override
  State<BookForLater> createState() => _BookForLaterState();
}

class _BookForLaterState extends State<BookForLater> {

  List<bool> progressStatus = [false, true, false, false];

  late List<String> selectedSlots;

  Color color1 = const Color.fromRGBO(51, 51, 51, 1);
  Color color2 = const Color.fromRGBO(217, 217, 217, 1);
  Color color3 = const Color.fromRGBO(241, 135, 0, 1);
  Color color4 = const Color.fromRGBO(197, 197, 197, 1);
  Color color5 = const Color.fromRGBO(0, 151, 218, 1);


  Widget buildProgressIndicator(int step) {
    // Memeriksa apakah kotak progresif harus diisi atau tidak
     bool filled = progressStatus[step - 1];
    // Warna kotak progresif berdasarkan status
    Color color = filled ? color3 : color4;
    return Container(
      width: 72,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
        border: Border.all(color: color)
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    selectedSlots = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        // ini buat ilangin navigationUp dari navigasi bawaan emulator androidnya biar kita bisa pake icon kita sendiri
        flexibleSpace: const Image(
          image: AssetImage('assets/image/whitebackground.png'),
          fit: BoxFit.cover,
        ), 
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 23.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgressIndicator(1),
                  buildProgressIndicator(2),
                  buildProgressIndicator(3),
                  buildProgressIndicator(4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0, 0),
                    child: IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, 
                      icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                  padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 5.0),
                  child: Text(
                    'Pilih Waktu Kunjunganmu!',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: color1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45.0, 2.0, 45.0, 0),
                  child: Text(
                    'Pastikan kamu memilih waktu yang benar untuk kunjungan. Tips: jika tidak memungkinkan untuk keluar LKC pada waktu yang ada, kamu dapat memilih 2 sesi berturut saja.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                      color: color1,
                      fontSize: 11.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 5.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    itemBuilder: (context, index){
                      final startTime = (index + 8).toString().padLeft(2,'0');
                      final endTime = (int.parse(startTime) + 1).toString().padLeft(2,'0');
                      final rangetime = '$startTime.00 - $endTime.00';
                      return SizedBox(
                        width: 290,
                        height: 42,
                        child: PhysicalModel(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(17),
                          shadowColor: const Color.fromRGBO(237, 237, 237, 1).withOpacity(0.1),
                          elevation: 5,
                          child: Container(
                            margin: const EdgeInsets.all(1.0), 
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: selectedSlots.contains(rangetime) ? color5 :const Color.fromRGBO(194, 194, 194, 1).withOpacity(0.3)), 
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: SizedBox(
                                  child: Text(
                                    rangetime,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      ),
                                    ),
                                ),
                              ),
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                ),
                              checkColor: Colors.blue,
                              fillColor: MaterialStateProperty.all(Colors.transparent),
                              side: MaterialStateBorderSide.resolveWith((states){
                                if(states.contains(MaterialState.selected)){
                                  return BorderSide(color:color5);
                                }else{
                                  return BorderSide(color: color4);
                                }
                              }),
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: selectedSlots.contains(rangetime),
                              onChanged: (value){
                                setState(() {
                                  if(value != null && value){
                                      final newSlot = '$startTime.00 - $endTime.00';
                                      // Hapus waktu kunjungan sebelumnya jika ada
                                      selectedSlots.removeWhere((slot) {
                                        final parts = slot.split('-');
                                        final slotStartTime = int.parse(parts[0].trim().split('.')[0]);
                                        final slotEndTime = int.parse(parts[1].trim().split('.')[0]);
                                        return slotStartTime == int.parse(startTime) && slotEndTime <= int.parse(endTime);
                                        });
                                      
                                      selectedSlots.add(newSlot);
                                    } else {
                                      selectedSlots.remove('$startTime.00 - $endTime.00');
                                    }
                                    selectedSlots.sort((a,b)=> int.parse(a.split('.')[0]).compareTo(int.parse(b.split('.')[0])));
                                });
                              },
                            )
                          ),
                        ),
                      );
                    }
                    ),
                ),
                const SizedBox(height: 26.0),
                const Padding(
                  padding: EdgeInsets.only(left: 45.0),
                  child: Text(
                    'Waktu Kunjungan',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedSlots.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(45.0, 5.0, 45.0, 0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Column(
                          children: groupSelectedSlots(selectedSlots)
                            .map((group) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(padding:EdgeInsets.all(2.0)),
                              Expanded(
                                child: Text(
                                  '${group.startTime} - ${group.endTime} WIB',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                  textAlign: TextAlign.left
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${group.sessions} sesi',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                textAlign: TextAlign.right
                                ),
                              )
                            ],
                          );
                        }).toList(),
                        )
                      ],
                    ),
                  )
                ),
                const SizedBox(height: 2.0),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                  indent: 45.0,
                  endIndent: 45.0,
                ),
                const SizedBox(height: 10.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context, 
                      //   MaterialPageRoute(builder: (context)=> ) // tar ke booking page 3
                      //   );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color3,
                      fixedSize: const Size(136, 33),
                      elevation: 5,
                    ),
                    child: const Text(
                        'Selanjutnya',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      }, 
                      child: const Text(
                        'Sebelumnya..',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationThickness: 0.2,
                          color: Color.fromRGBO(141, 141, 141, 1),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

List<GroupedTimeSlot> groupSelectedSlots(List<String> selectedSlots) {
  List<GroupedTimeSlot> groupedSlots = [];

  for (var slot in selectedSlots) {
    var parts = slot.split('-');
    var startTime = parts[0].trim();
    var endTime = parts[1].trim();

    if (groupedSlots.isNotEmpty) {
      var lastSlot = groupedSlots.last;
      if (lastSlot.endTime == startTime) {
        lastSlot = GroupedTimeSlot(
          startTime: lastSlot.startTime,
          endTime: endTime, 
          sessions: lastSlot.sessions + 1, 
        );
        groupedSlots.removeLast(); 
        groupedSlots.add(lastSlot); 
        continue; 
      }
    }
    groupedSlots.add(GroupedTimeSlot(startTime: startTime, endTime: endTime, sessions: 1));
  }

  return groupedSlots;
}

}

class GroupedTimeSlot {
  final String startTime;
  final String endTime;
  int sessions;

  GroupedTimeSlot({required this.startTime, required this.endTime, required this.sessions});
}