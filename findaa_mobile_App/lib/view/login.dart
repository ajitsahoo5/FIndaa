import 'dart:ui';

import 'package:findaa/presenter/data.dart';
import 'package:findaa/view/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'business_ownerHome.dart';
import 'customerHome.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userId = TextEditingController();
  var password = TextEditingController();
  var user1 = User("Ajit Sahoo", "987654321", "123456", true);
  var user2 = User("Badal Mahakud", "123456789", "123456", false);

  @override
  Widget build(BuildContext context) {
    Widget buildLoginCredentials() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Proceed with your login details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: TextField(
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.orange[900],
                ),
                hintText: "Enter your Mobile number",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              keyboardType: TextInputType.phone,
              controller: userId,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: TextField(
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.orange[900],
                ),
                hintText: "Enter your 6 digits PIN",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              obscureText: true,
              keyboardType: TextInputType.phone,
              controller: password,
            ),
          )
        ],
      );
    }

    bool isUserPresent = false;
    User loginUser;

    Widget buildLoginBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () => {
            if (user1.mobileNo == userId.text)
              {
                isUserPresent = true,
                loginUser = user1,
              }
            else if (user2.mobileNo == userId.text)
              {
                isUserPresent = true,
                loginUser = user2,
              }
            else
              {
                isUserPresent = false,
              },
            if (isUserPresent)
              {
                if (loginUser.pin == password.text)
                  {
                    if (loginUser.isCustomer)
                      {
                        FindaaData.isCustomer = true,
                        Navigator.pop(context),
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CustomerHome(),
                          ),
                        )
                      }
                    else if (loginUser.isCustomer)
                      {
                        FindaaData.isCustomer = false,
                        Navigator.pop(context),
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BusinessOwnerHome(),
                          ),
                        )
                      }
                  }
              }
          },
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.orange[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      );
    }

    Widget buildForgotBtn() {
      return Container(
        alignment: Alignment.centerLeft,
        child: FlatButton(
          onPressed: () => print("Forgot is clicked"),
          child: Text(
            'Forgot password?',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }

    Widget buildSignupBtn() {
      TextStyle defaultStyle =
          TextStyle(color: Colors.orange[100], fontSize: 16);
      TextStyle linkStyle = TextStyle(color: Colors.white);
      return RichText(
        text: TextSpan(
          style: defaultStyle,
          children: <TextSpan>[
            TextSpan(text: 'New User? '),
            TextSpan(
              text: 'SIGNUP',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () => {
                      Navigator.pop(context, true),
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUpPage()))
                    },
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange[900],
                      Colors.orange,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "images/logo.png",
                          ),
                          Text(
                            "Findaa",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                      buildLoginCredentials(),
                      SizedBox(height: 20),
                      buildLoginBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildForgotBtn(),
                          buildSignupBtn(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        value: SystemUiOverlayStyle.light,
      ),
    );
  }
}
