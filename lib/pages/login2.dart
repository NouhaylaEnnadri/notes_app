import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/pages/signup.dart';
import '../firebase_auth_implemnetation/auth.dart';

class Login2 extends StatefulWidget {
  const Login2({Key? key}) : super(key: key);

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  TextEditingController myEmail = TextEditingController();
  TextEditingController myPwd = TextEditingController();
  Auth auth = Auth(); // Instantiate the Auth class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image positioned to the far left
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'images/img2.png',
                  height: 150,
                ),
              ),
            ),

            // Space between them
            SizedBox(height: 20),

            // Welcome Back:
            Text(
              "Welcome Back!",
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
                      SizedBox(height: 10),

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
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.password)),
                        obscureText: true,
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          Text('Already have an account'),
                          TextButton( onPressed: () {
                            // Navigate to another page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          }, child: Text('Sign Up'))
                        ],
                      ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {auth.signIn(myEmail.text, myPwd.text, context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shadowColor: textColor,
                          backgroundColor: secondPrimary,
                          minimumSize: Size.fromHeight(40),
                        ),
                        child: Text(
                          "Login",
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
                          "or login with",
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

