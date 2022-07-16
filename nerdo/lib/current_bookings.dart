import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrentBookings extends StatefulWidget {
  final String token;

  const CurrentBookings({required this.token});

  @override
  State<CurrentBookings> createState() => _CurrentBookingsState();
}

class _CurrentBookingsState extends State<CurrentBookings> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future<List<Booking>> initializeCurrentBookings(String token) async {
    var url = Uri.parse('http://$IP_ADDRESS/current_bookings');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "token": token,
        },
      ),
    );

    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    final extractedMyInfo = json.decode(response.body) as Map<String, dynamic>;
    List<dynamic> bookingInfo = extractedMyInfo['bookings'];

    List<Booking> bookings = [];
    for (int i = 0; i < bookingInfo.length; i++) {
      String start = bookingInfo[i][0];
      String end = bookingInfo[i][1];
      String slotID = bookingInfo[i][2];
      bookings.add(
        Booking(
          token: token,
          bookingNum: i + 1,
          startTime: start,
          endTime: end,
          slotID: slotID,
        ),
      );
    }

    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Booking>> currentBookings =
        initializeCurrentBookings(widget.token);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFf8b323),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "My Bookings",
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
        children: <Widget>[
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Booking>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Color(0xFFf8b323),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return snapshot.data![index];
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('No Data');
                }
              },
              future: currentBookings,
            ),
          )
        ],
      ),
    );
  }
}

Future cancelBooking(String token, String startTime, String slotID) async {
  var url = Uri.parse('http://$IP_ADDRESS/cancel_booking');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        "token": token,
        "slotID": slotID.toString(),
        "startTime": startTime
      },
    ),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

class Booking extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String slotID;
  final int bookingNum;
  final String token;

  Booking({
    required this.token,
    required this.startTime,
    required this.endTime,
    required this.slotID,
    required this.bookingNum,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.my_library_books_outlined,
      ),
      title: Text(
        'Booking ${bookingNum}',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          //fontFamily: 'RalewayMedium',
        ),
      ),
      subtitle: Text(
        //'Start and End Times',
        'Start date: ${startTime}\nEnd date: ${endTime}',
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
      trailing: GestureDetector(
        onTap: () {
          cancelBooking(token, startTime, slotID).then(
            (_) {
              Navigator.of(context).pop();
            },
          );
        },
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.red,
            fontFamily: 'RalewayMedium',
          ),
        ),
      ),
    );
  }
}
