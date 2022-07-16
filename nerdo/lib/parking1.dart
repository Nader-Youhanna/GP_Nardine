import 'package:flutter/material.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// TODO
// Check if endTime < startTime
// Check if dates and times are enterted

//Refresh duration in seconds
const refreshDuration = 120;

class Parking1 extends StatefulWidget {
  String token = "";
  Parking1({required this.token});
  @override
  State<Parking1> createState() => _Parking1State();
}

/*List must be initialized from Back End */

void _goBack(BuildContext ctx) {
  Navigator.of(ctx).pop();
}

class _Parking1State extends State<Parking1> {
  // @override
  // void initState() {
  //   super.initState();
  //   setState(
  //     () {
  //       const duration = Duration(seconds: refreshDuration);
  //       Timer.periodic(duration, (Timer t) => setState(() {}));
  //     },
  //   );
  // }

  Future<List<GarageSlot>> initializeSlots1(String token) async {
    var url = Uri.parse('http://$IP_ADDRESS/parking1_init');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;

    List<GarageSlot> slots = [];
    int j = 34;
    for (int i = 0; i < extractedMyInfo['parking'].length; i++) {
      slots.add(
        GarageSlot(
            busy: extractedMyInfo['parking'][i],
            index: j,
            row: 1,
            token: token),
      );
      j--;
    }
    return slots;
  }

  Future<List<GarageSlot>> initializeSlots2(String token) async {
    var url = Uri.parse('http://$IP_ADDRESS/parking2_init');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;

    List<GarageSlot> slots = [];
    int j = 19;
    for (int i = 0; i < extractedMyInfo['parking'].length; i++) {
      slots.add(
        GarageSlot(
            busy: extractedMyInfo['parking'][i],
            index: j,
            row: 2,
            token: token),
      );
      j--;
    }
    return slots;
  }

  Future<List<GarageSlot>> initializeSlots3(String token) async {
    var url = Uri.parse('http://$IP_ADDRESS/parking3_init');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;

    List<GarageSlot> slots = [];
    int j = 1;
    for (int i = 0; i < extractedMyInfo['parking'].length; i++) {
      slots.add(
        GarageSlot(
          busy: extractedMyInfo['parking'][i],
          index: j,
          row: 3,
          token: token,
        ),
      );
      j++;
    }
    return slots;
  }

  Widget garageSlotsbuilder(List<GarageSlot> garageSlots, bool rev) {
    return ListView.builder(
      reverse: rev,
      scrollDirection: Axis.horizontal,
      itemCount: garageSlots.length,
      itemBuilder: (context, index) {
        return garageSlots[index];
      },
    );
  }

  // List<GarageSlot> garageSlots1 = [
  //   GarageSlot(busy: false, index: 0),
  //   GarageSlot(busy: false, index: 1),
  //   GarageSlot(busy: false, index: 2),
  //   GarageSlot(busy: false, index: 3),
  //   GarageSlot(busy: false, index: 4),
  //   GarageSlot(busy: false, index: 5),
  //   GarageSlot(busy: false, index: 6),
  //   GarageSlot(busy: false, index: 7),
  //   GarageSlot(busy: false, index: 8),
  //   GarageSlot(busy: false, index: 9),
  //   GarageSlot(busy: false, index: 10),
  // ];

  // List<GarageSlot> garageSlots2 = [
  //   GarageSlot(busy: false, index: 0),
  //   GarageSlot(busy: false, index: 1),
  //   GarageSlot(busy: false, index: 2),
  //   GarageSlot(busy: false, index: 3),
  //   GarageSlot(busy: false, index: 4),
  //   GarageSlot(busy: false, index: 5),
  //   GarageSlot(busy: false, index: 6),
  //   GarageSlot(busy: false, index: 7),
  // ];

  @override
  Widget build(BuildContext context) {
    Future<List<GarageSlot>> garageSlots1 = initializeSlots1(widget.token);
    Future<List<GarageSlot>> garageSlots2 = initializeSlots2(widget.token);
    Future<List<GarageSlot>> garageSlots3 = initializeSlots3(widget.token);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFf8b323),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Garages Available",
                style: TextStyle(
                    //fontFamily: 'RalewayMedium',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            _goBack(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Scroll Sideways to see all parking slots",
            style: TextStyle(
              fontFamily: 'RalewayMedium',
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: FutureBuilder<List<GarageSlot>>(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color(0xFFf8b323),
                        );
                      } else if (snapshot.hasData) {
                        final garageSlots = snapshot.data!;
                        return garageSlotsbuilder(garageSlots, true);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('No Data');
                      }
                    },
                    future: garageSlots1,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: FutureBuilder<List<GarageSlot>>(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color(0xFFf8b323),
                        );
                      } else if (snapshot.hasData) {
                        final garageSlots = snapshot.data!;
                        return garageSlotsbuilder(garageSlots, true);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('No Data');
                      }
                    },
                    future: garageSlots2,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: FutureBuilder<List<GarageSlot>>(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color(0xFFf8b323),
                        );
                      } else if (snapshot.hasData) {
                        final garageSlots = snapshot.data!;
                        return garageSlotsbuilder(garageSlots, false);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('No Data');
                      }
                    },
                    future: garageSlots3,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GarageSlot extends StatefulWidget {
  Future<void> book() async {
    print('Start Date: $globalStartDate - End Date: $globalEndDate');
    print('Start Time: $globalStartTime - End Time: $globalEndTime');
    print('index: $index');
    var url = Uri.parse('http://$IP_ADDRESS/book');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "index": '$index',
          "token": token,
          "startDate": '$globalStartDate $globalStartTime',
          "endDate": '$globalEndDate $globalEndTime'
        },
      ),
    );
  }

  bool busy = false;
  int index;
  int row;
  String token = '';
  String startDate = '';
  String endDate = '';

  GarageSlot(
      {required this.busy,
      required this.index,
      required this.row,
      required this.token});

  @override
  State<GarageSlot> createState() => _GarageSlotState();
}

String globalStartDate = '';
String globalEndDate = '';
String globalStartTime = '';
String globalEndTime = '';

void setStartDate(String startDate) {
  globalStartDate = startDate;
}

void setEndDate(String endDate) {
  globalEndDate = endDate;
}

void setStartTime(String startTime) {
  globalStartTime = startTime;
}

void setEndTime(String endTime) {
  globalEndTime = endTime;
}

class _GarageSlotState extends State<GarageSlot> {
  Future chooseDateAndTime(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose the time of the booking'),
          content: DateTimePickingWidget(),
          actions: [
            TextButton(
              child: const Text(
                'SUBMIT',
              ),
              onPressed: () {
                widget.book();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 50,
      child: GestureDetector(
        onTap: () async {
          if (!widget.busy) {
            await chooseDateAndTime(context);
            setState(
              () {
                widget.busy = true;
              },
            );
          }
        },
        child: Card(
          color: widget.busy ? Colors.grey : Colors.green,
          child: const Icon(
            Icons.directions_car_rounded,
          ),
        ),
      ),
    );
  }
}

class DateTimePickingWidget extends StatelessWidget {
  late DateTime startDate;
  late DateTime endDate;
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  String getStartDate() {
    return '${startDate.year}-${startDate.month}-${startDate.day}';
  }

  String getEndDate() {
    return '${endDate.year}-${endDate.month}-${endDate.day}';
  }

  String getStartTime() {
    return '${startTime.hour}:${startTime.minute}:00';
  }

  String getEndTime() {
    return '${endTime.hour}:${endTime.minute}:00';
  }

  Future pickDate(BuildContext context, bool start) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    if (start) {
      startDate = newDate;
      setStartDate(getStartDate());
    } else {
      endDate = newDate;
      setEndDate(getEndDate());
    }
  }

  Future pickTime(BuildContext context, bool start) async {
    const initialTime = const TimeOfDay(hour: 10, minute: 0);
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (newTime == null) return;
    if (start) {
      startTime = newTime;
      setStartTime(getStartTime());
    } else {
      endTime = newTime;
      setEndTime(getEndTime());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Date Range',
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    primary: Color.fromARGB(255, 255, 199, 78),
                  ),
                  onPressed: () {
                    pickTime(context, true);
                    pickDate(context, true);
                  },
                  child: const FittedBox(
                    child: Text(
                      'From',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    primary: Color.fromARGB(255, 255, 199, 78),
                  ),
                  onPressed: () {
                    pickTime(context, false);
                    pickDate(context, false);
                  },
                  child: const FittedBox(
                    child: Text(
                      'To',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
