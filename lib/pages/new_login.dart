import 'package:flutter/material.dart';

import '../constants.dart';
import 'login.dart';
import 'login2.dart';


class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              bottom: -screenHeight / 1500,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: firstPrimary,
                height: screenHeight / 2,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to another page
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login2()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonCor), // Change the button color
                      foregroundColor: MaterialStateProperty.all(secondPrimary), // Change the text color
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: 18.0, // Change the text size
                        ),
                      ),
                    ),
                    child: const Text('Login'),
                  ), // Add this closing parenthesis
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight / 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: firstPrimary,
                height: screenHeight / 8,
              ),
            ),
            Positioned(
              left: 35,
              child: Image.asset(
                'images/img1.png',
                height: screenHeight / 2,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
