import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/logic/services/sign_in_service.dart';
import 'package:flutter_shoppinglist/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Text(
                        'PERSONAL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 42.0,
                          fontFamily: 'Oxygen',
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 16.0,
                              offset: Offset(8.0, 8.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 80.0),
                      child: Text(
                        'SHOPPER',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 42.0,
                          fontFamily: 'Oxygen',
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              blurRadius: 16.0,
                              offset: Offset(-8.0, 8.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox.fromSize(
                size: Size(200, 200),
                child: Image.asset('assets/shopping-cart.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _signInButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return RaisedButton(
      elevation: 4.0,
      onPressed: () async {
        String result;
        try {
          result = await SignInService().signInWithGoogle();
        } catch (error) {
          print('Something went wrong, trying to sign in:');
          print(error);
        }
        if (result != null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (_) => false,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/google_logo.png',
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
