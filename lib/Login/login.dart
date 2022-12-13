import 'package:admin_master/DialogBox/loadingDialog.dart';
import 'package:admin_master/Login/backgroundPainter.dart';
import 'package:admin_master/MainScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../DialogBox/errorDialog.dart';

class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email="";
  String password="";


  returnEmailField(IconData icon, bool isObscure){

    return TextField(
      onChanged: (value){
        email =value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 15.0,color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          icon,
          color: Colors.green,
        ),
      ),
    );
  }


  returnPasswordField(IconData icon, bool isObscure){

    return TextField(
      onChanged: (value){
        password =value;
      },
      obscureText: isObscure,
      style: TextStyle(fontSize: 15.0,color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          icon,
          color: Colors.green,
        ),
      ),
    );
  }

  returnLoginButton(){
    return ElevatedButton(onPressed: (){
      if(email != "" && password != ""){
        loginAdmin();
      }
    },
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2.0,
          fontSize: 16.0
        ),
      ),
        );
  }



  loginAdmin()  async
  {
    showDialog(
        context: context,
        builder: (context){
          return LoadingAlertDialog(
            message: "Please wait....",

          );
        }
    );

    User currentUser;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((aAuth){
      currentUser=aAuth.user;
    }).catchError((error){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context){
            return ErrorAlertDialog(
              message:"Error Occurred:" +error.toString(),

            );
          }
      );



    });
    if(currentUser != null){
      //homepage
      Route newRoute = MaterialPageRoute(builder: (context)=> HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
    else{
      //login Page
      Route newRoute = MaterialPageRoute(builder: (context)=> LoginScreen());
      Navigator.pushReplacement(context, newRoute);
    }
}

  @override
  Widget build(BuildContext context) {
    
    double _screenWidth= MediaQuery.of(context).size.width,
        _screenHeight=MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.black ,
      body: Stack(
        alignment: Alignment.lerp(
          Alignment.lerp(Alignment.centerRight, Alignment.center, 0.3),
        Alignment.topCenter,
          0.15,
        ),

        children: [
          CustomPaint(
            painter: BackgroundPainter(),
            child: Container(height: _screenHeight,),
          ),
          Center(
            child: Container(
              width: _screenWidth * .5,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Image.asset("images/admin.png",width: 300,height: 300,),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 50),
                    child: returnEmailField(Icons.person,false),
                  ),
                  SizedBox(height: 20,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 50),
                    child: returnPasswordField(Icons.person,true),
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 50),
                        child: returnLoginButton(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
