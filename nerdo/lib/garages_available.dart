import 'package:flutter/material.dart';
import 'parking1.dart';

class GaragesAvailable extends StatelessWidget {
  String token="";
  GaragesAvailable({required this.token});
  void _goToParking1(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Parking1(token: token);
        },
      ),
    );
  }

  void _goBack(BuildContext ctx)
  {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf8b323),
        centerTitle: true,
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
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    _goToParking1(context);
                  },
                  leading: const Icon(
                    Icons.directions_car,
                  ),
                  title: const Text(
                    'Parking 1',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.directions_car,
                  ),
                  title: Text(
                    'Parking 2',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
