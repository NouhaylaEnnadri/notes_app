import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

import '../firebase_auth_implemnetation/auth.dart';
import 'login2.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _Login2State();
}

class _Login2State extends State<SignUp> {
  TextEditingController myEmail = TextEditingController();
  TextEditingController myPwd = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController verifyPwd = TextEditingController();
  Auth auth = Auth(); // Instantiate the Auth class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image positioned to the far left
           /* Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'images/img2.png',
                  height: 150,
                ),
              ),
            ),*/

            // Space between them
            SizedBox(height: 50),

            // Welcome Back:
            Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 32,
              ),
            ),

            // Space between them
            SizedBox(height: 10),

            // Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Space between them
                      //SizedBox(height: 10),

                      Text(
                        'Username:',
                        style: TextStyle(color: textColor),
                      ),
                      TextField(
                        controller: user,
                        decoration: InputDecoration(suffixIcon: Icon(Icons.person)),
                        obscureText: false,
                      ),

                      SizedBox(height: 20),

                      Text(
                        'Email Address:',
                        style: TextStyle(color: textColor),
                      ),
                      TextField(
                        controller: myEmail,
                        decoration: InputDecoration(suffixIcon: Icon(Icons.email)),
                        obscureText: false,
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Password:',
                        style: TextStyle(color: textColor),
                      ),
                      TextField(
                        controller: myPwd,
                        decoration: InputDecoration(suffixIcon: Icon(Icons.password)),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),

                      Text(
                        'Verify password:',
                        style: TextStyle(color: textColor),
                      ),
                      TextField(
                        controller: verifyPwd,
                        decoration: InputDecoration(suffixIcon: Icon(Icons.password_sharp)),
                        obscureText: false,
                      ),
                      Row(
                        children: [
                          Text('Already have signed up '),
                          TextButton( onPressed: () {
                            // Navigate to another page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login2()),
                            );
                          }, child: Text('Sign in'))
                        ],
                      ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          auth.signUp(myEmail.text, myPwd.text, user.text, context);

                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shadowColor: textColor,
                          backgroundColor: secondPrimary,
                          minimumSize: Size.fromHeight(40),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Center(
                        child: Text(
                          "or Sign up  with",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Tab(
                            icon: SizedBox(
                              width: 32, // Set the desired width
                              height: 32, // Set the desired height
                              child: Image.asset('images/facebook.png'),
                            ),
                          ),
                          Tab(
                            icon: SizedBox(
                              width: 32, // Set the desired width
                              height: 32, // Set the desired height
                              child: Image.asset('images/twitter.png'),
                            ),
                          ),
                          Tab(
                            icon: SizedBox(
                              width: 32, // Set the desired width
                              height: 32, // Set the desired height
                              child: Image.asset('images/github.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
