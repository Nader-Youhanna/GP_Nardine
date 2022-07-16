import 'package:flutter/material.dart';

class CarDetails extends StatelessWidget {
  final String carLicense;
  final String carBrand;
  final String carColour;

  CarDetails({
    required this.carLicense,
    required this.carBrand,
    required this.carColour,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Center(
            widthFactor: 0.5,
            heightFactor: 1,
            child: Icon(
              Icons.directions_car,
              size: 45,
              color: carColour == 'Red' || carColour == 'red'
                  ? Colors.red
                  : carColour == 'Blue' || carColour == 'blue'
                      ? Colors.blue
                      : carColour == 'Green' || carColour == 'green'
                          ? Colors.green
                          : Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Car License',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              trailing: Text(carLicense),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Car Brand',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                carBrand,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Car Colour',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              trailing: Text(
                carColour,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
