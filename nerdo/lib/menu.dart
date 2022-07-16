import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nerdo/current_bookings.dart';
import 'package:nerdo/garages_available.dart';
import 'package:nerdo/home.dart';
import 'ContactUs.dart';
import 'Settings.dart';
import 'profile.dart';
import 'booking_history.dart';
import 'how_it_works.dart';

class Menu extends StatefulWidget {
  String token = "";

  final String name;
  final String email;
  final String gender;
  final String phone;
  final String carLicense;
  final String carBrand;
  final String carColour;

  Menu({
    required this.name,
    required this.email,
    required this.gender,
    required this.token,
    required this.phone,
    required this.carLicense,
    required this.carBrand,
    required this.carColour,
  });

  @override
  State<Menu> createState() => _MenuState();
}

void _goToUserProfile(
  BuildContext ctx,
  String name,
  String email,
  String phone,
  String gender,
  String carLicense,
  String carBrand,
  String carColour,
) {
  Navigator.of(ctx).push(
    MaterialPageRoute(builder: (_) {
      return Profile(
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        carLicense: carLicense,
        carBrand: carBrand,
        carColour: carColour,
      );
    }),
  );
}

void _goToGaragesAvailable(BuildContext ctx, String token) {
  Navigator.of(ctx).push(
    MaterialPageRoute(builder: (_) {
      return GaragesAvailable(token: token);
    }),
  );
}

void _goToHome(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(builder: (_) {
      return Home();
    }),
  );
}

void _goToSettings(BuildContext ctx, String token, String name) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return Settings(
          token: token,
          name: name,
        );
      },
    ),
  );
}

void _goContactUs(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return ContactUS();
      },
    ),
  );
}

void _goToCurrentBookings(BuildContext ctx, String token) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return CurrentBookings(
          token: token,
        );
      },
    ),
  );
}

void _goToBookingHistory(BuildContext ctx, String token) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return BookingHistory(
          token: token,
        );
      },
    ),
  );
}

void _goToHowItWorks(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return HowItWorks();
      },
    ),
  );
}

class _MenuState extends State<Menu> {
  bool _usernameIsEntered = false;
  bool _passwordIsEntered = false;
  String _username = '';
  String _password = '';

  double screenWidth = 0;
  double screenHeight = 0;

  final String title = "Rakeny";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFf8b323),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'images/cover_image_sidebar.jpg',
                ), //Cover Image
              ),
            ),
            onDetailsPressed: () {
              _goToUserProfile(
                context,
                widget.name,
                widget.email,
                widget.phone,
                widget.gender,
                widget.carLicense,
                widget.carBrand,
                widget.carColour,
              );
            },
            accountName: Text(
              widget.name,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              widget.email,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'images/user_icon.png',
                  fit: BoxFit.contain,
                ),
                // child: Image.network(
                //   userImage,
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
          ),
          /**********************/
          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.orangeAccent,
          //   ),
          //   child: Text('Profile'), // mmkn n7ot hena el usernaame
          // ),
          /*******************************/
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 27,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goToUserProfile(
                context,
                widget.name,
                widget.email,
                widget.phone,
                widget.gender,
                widget.carLicense,
                widget.carBrand,
                widget.carColour,
              );
            },
          ),
          ListTile(
            onTap: () {
              _goToGaragesAvailable(context, widget.token);
            },
            leading: const Icon(
              Icons.directions_car_filled,
              size: 27,
            ),
            title: const Text(
              'Garages Available',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.book,
              size: 27,
            ),
            title: const Text(
              'My Current Bookings',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goToCurrentBookings(context, widget.token);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              size: 27,
            ),
            title: const Text(
              'My Booking History',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goToBookingHistory(context, widget.token);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              size: 27,
            ),
            title: const Text(
              'How it works',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goToHowItWorks(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 27,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goToSettings(context, widget.token, widget.name);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.message,
              size: 27,
            ),
            title: const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goContactUs(context);
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 27,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              _goToHome(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 27,
            ),
            title: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayMedium',
              ),
            ),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
