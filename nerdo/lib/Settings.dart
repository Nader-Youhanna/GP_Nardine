import 'package:flutter/material.dart';
import 'package:nerdo/Payment.dart';
import 'edit_profile.dart';

class Settings extends StatefulWidget {
  String token = '';
  String name = "";
  Settings({required this.name, required this.token});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void _goToEditProfile(BuildContext ctx, String token, String name) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return EditProfile(
            token: token,
            name: name,
          );
        },
      ),
    );
  }

  void _goToPayment(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Payment();
      }),
    );
  }

  void _goBack(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  void initState() {
    setState(() {
      //getuserData();
    });
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
                text: "Settings",
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
                    _goToEditProfile(context, widget.token, widget.name);
                  },
                  leading: const Icon(Icons.person),
                  title: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: const Text(
                    'Change your account information like your phone number and email address.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _goToPayment(context);
                  },
                  leading: const Icon(
                    Icons.attach_money_sharp,
                  ),
                  title: const Text(
                    'Payment',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: const Text(
                    'Change your payment method.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
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
