import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ChangeAvatar extends StatelessWidget {
  const ChangeAvatar({Key? key}) : super(key: key);
  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFf8b323),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Edit Avatar",
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
                Row(
                  children: [
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: () {
                        print("Male\n");
                      },
                      child: const Image(
                        image: AssetImage('images/male_icon.jpg'),
                        height: 100,
                      ),
                    ),
                    const SizedBox(width: 75),
                    GestureDetector(
                      onTap: () {
                        print("Female\n");
                      },
                      child: const Image(
                        image: AssetImage('images/female_icon.jpg'),
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
