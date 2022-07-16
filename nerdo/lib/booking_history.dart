import 'package:flutter/material.dart';
import 'config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingHistory extends StatefulWidget {
  final String token;

  const BookingHistory({required this.token});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  Future<List<ListTile>> initializeBookingHistory(String token) async {
    var url = Uri.parse('http://$IP_ADDRESS/booking_history');
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

    List<ListTile> bookings = [];
    for (int i = 0; i < bookingInfo.length; i++) {
      String start = bookingInfo[i][0];
      String end = bookingInfo[i][1];
      bookings.add(
        ListTile(
          leading: const Icon(
            Icons.my_library_books_outlined,
          ),
          title: Text(
            'Booking ${i + 1}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              //fontFamily: 'RalewayMedium',
            ),
          ),
          subtitle: Text(
            //'Start and End Times',
            'Start date: ${start}\nEnd date: ${end}',
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    }

    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<ListTile>> currentBookings =
        initializeBookingHistory(widget.token);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFf8b323),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "My Bookings History",
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
            child: FutureBuilder<List<ListTile>>(
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
