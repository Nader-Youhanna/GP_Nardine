import 'package:flutter/material.dart';
import 'login.dart';
import 'sign_up.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void _goToLogin(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return Login();
      }),
    );
  }

  void _goToSignUp(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return SignUp();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8b323),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Center(
              child: Image(
                fit: BoxFit.fitHeight,
                image: AssetImage('images/logorakeny.PNG'),
              ),
            ),
            const SizedBox(
              height: 220,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade700),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 235, 171, 33),
                    ),
                  ),
                  onPressed: () {
                    _goToLogin(context);
                  },
                  // onPressed: null,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 90,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade700),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 235, 171, 33),
                    ),
                  ),
                  onPressed: () {
                    _goToSignUp(context);
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
