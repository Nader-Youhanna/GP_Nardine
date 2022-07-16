import 'package:flutter/material.dart';
import 'edit_avatar.dart';
import 'change_username.dart';
import 'change_password.dart';
import 'change_car_details.dart';

class EditProfile extends StatefulWidget {
  String token = '';
  String name;
  EditProfile({required this.token, required this.name});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void _goToEdit_Avatar(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ChangeAvatar();
      }),
    );
  }

  void _goChangeUsername(BuildContext ctx, String token, String name) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ChangeUsername(token: token, name: name);
      }),
    );
  }

  void _goChangePassword(BuildContext ctx, String token) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ChangePassword(token: token);
      }),
    );
  }

  void _goChangeCarDetails(
    BuildContext ctx,
    String token,
  ) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return ChangeCarDetails(
          token: token,
        );
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
        centerTitle: true,
        backgroundColor: Color(0xFFf8b323),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Edit Profile",
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
                    _goChangeUsername(context, widget.token, widget.name);
                  },
                  leading: const Icon(Icons.person),
                  title: const Text(
                    'Change Username',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _goChangePassword(context, widget.token);
                  },
                  leading: const Icon(Icons.key),
                  title: const Text(
                    'Change Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.mail,
                  ),
                  title: const Text(
                    'Change Email',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _goChangeCarDetails(context, widget.token);
                  },
                  leading: const Icon(
                    Icons.garage_outlined,
                    size: 26,
                  ),
                  title: const Text(
                    'Change Car Info',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.image,
                  ),
                  title: const Text(
                    'Change Avatar',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    _goToEdit_Avatar(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
