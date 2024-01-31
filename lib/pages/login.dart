import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController myEmail = TextEditingController();
  TextEditingController myPwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration:  BoxDecoration(
        color: Colors.lightBlue,
        image: DecorationImage(
            image: AssetImage("images/bgImage.jpg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop)
          )
        ),
  child:Scaffold (
    backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Icon(
                Icons.facebook,
                size : 60 ,
                color: Colors.grey,
              ),
              Text(
                "Note it girl",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize:  15,
                      letterSpacing: 2

                    ),
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),

                  )
                ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                        'WELCOME ',
                        style : TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 32,
                          fontWeight: FontWeight.w500

                        )

                      ),
                      Text(
                        'Take notes of your daily life and please sign in ',
                            style: TextStyle(
                              color : Colors.grey )
                      ),
                        SizedBox(height : 60),
                      Text(
                        'Email Adress : ',
                          style: TextStyle(
                              color : Colors.lightBlue )
                      ),
                      TextField(

                        controller: myEmail,
                        decoration : InputDecoration(
                          suffixIcon: Icon(Icons.email)
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height : 20  ),

                      Text(
                          'Password : ',
                          style: TextStyle(
                              color : Colors.lightBlue )

                      ),
                      TextField(

                        controller: myPwd,
                        decoration : InputDecoration(
                            suffixIcon: Icon(Icons.password)
                        ),
                        obscureText: true,
                      ),

                      SizedBox(height : 20  ),
                      Row(
                        children: [
                          Text('already have an acount'),
                          TextButton(onPressed: (){

                          }, child: Text('SignUp'))
                        ],
                      ),

                      SizedBox(height : 20  ),
                      ElevatedButton(onPressed: (){

                      },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            elevation: 5,
                            shadowColor: Colors.lightBlue,
                            minimumSize: Size.fromHeight(60)
                          ),

                       child: Text('Login')
                      ),
                      SizedBox(height : 20  ),
                      Center(
                        child:Text(
                          "or login with ",
                          style : TextStyle(
                            color : Colors.black,
                          )
                        )
                      ),
                      SizedBox(height : 10  ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                       Tab(icon :  Image.asset('images/fb.jpg')),
                          Tab(icon :  Image.asset('images/twitter.jpg')),
                          Tab(icon :  Image.asset('images/github.jpg')),                    ],
                      ),

                  ],
              ),
                    )
              )
            ],
          ),
        )
    )
    );
  }
}
