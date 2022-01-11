import 'package:findaa/api/restapi.dart';
import 'package:findaa/presenter/data.dart';
import 'package:findaa/view/login.dart';
import 'package:findaa/view/otpVarificaion.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isCustomer = true;
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var mobileNoController = TextEditingController();
  var cityController = TextEditingController();
  var locationController = TextEditingController();

  TextStyle errorTextStyle = TextStyle(
    color: Colors.red,
    fontStyle: FontStyle.italic,
  );

  var fNameError = "";
  var lNameError = "";
  var mobileError = "";
  var cityError = "";
  var locationError = "";

  var selectedType = TextStyle(
    color: Colors.orange[900],
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  var nonSelectedType = TextStyle(
    color: Colors.black87,
    fontSize: 18,
  );
  TextStyle defaultStyle = TextStyle(color: Colors.black38, fontSize: 16);
  TextStyle linkStyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    FindaaData data = new FindaaData();
    Widget buildRegistationForm() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Let's Get Started!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                "images/logo2.png",
                height: 35,
                width: 35,
              )
            ],
          ),
          SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            child: TextField(
              controller: fNameController,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.orange[900],
                ),
                hintText: "First Name",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              fNameError,
              textAlign: TextAlign.right,
              style: errorTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            child: TextField(
              controller: lNameController,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.orange[900],
                ),
                hintText: "Last Name",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              lNameError,
              textAlign: TextAlign.right,
              style: errorTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            child: TextField(
              controller: mobileNoController,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone_android_outlined,
                  color: Colors.orange[900],
                ),
                hintText: "Enter your Mobile Number",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.phone,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              mobileError,
              textAlign: TextAlign.right,
              style: errorTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            child: TextField(
              controller: cityController,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.orange[900],
                ),
                hintText: "Select City",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              cityError,
              textAlign: TextAlign.right,
              style: errorTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            child: TextField(
              controller: locationController,
              style: TextStyle(color: Colors.black87, fontSize: 16),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.location_city_outlined,
                  color: Colors.orange[900],
                ),
                hintText: "Select Locality",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              locationError,
              textAlign: TextAlign.right,
              style: errorTextStyle,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isCustomer ? Colors.orange[900] : Colors.black38,
                    ),
                  ),
                  height: 100,
                  width: 150,
                  child: Text(
                    "Registered as Customer",
                    style: isCustomer ? selectedType : nonSelectedType,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(() {
                    isCustomer = true;
                  });
                },
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: !isCustomer ? Colors.orange[900] : Colors.black38,
                    ),
                  ),
                  height: 100,
                  width: 150,
                  child: Text(
                    "Registered as Business Owner",
                    style: !isCustomer ? selectedType : nonSelectedType,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  setState(
                    () {
                      isCustomer = false;
                    },
                  );
                },
              )
            ],
          ),
          SizedBox(height: 05),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                bool isValidate = true;
                String firstName = fNameController.text;
                String lastName = lNameController.text;
                String mobileNo = mobileNoController.text;
                String city = cityController.text;
                String locality = locationController.text;
                if (firstName == '') {
                  isValidate = false;
                  setState(() {
                    fNameError = "* First name can not be empty.";
                  });
                } else {
                  setState(() {
                    fNameError = "";
                  });
                }
                if (lastName == '') {
                  isValidate = false;
                  setState(() {
                    lNameError = "* Last name can not be empty.";
                  });
                } else {
                  setState(() {
                    lNameError = "";
                  });
                }

                if (mobileNo == '') {
                  isValidate = false;
                  setState(() {
                    mobileError = "* Mobile no can not be empty.";
                  });
                } else {
                  setState(() {
                    mobileError = "";
                  });
                }
                if (city == '') {
                  isValidate = false;
                  setState(() {
                    cityError = "* City can not be empty.";
                  });
                } else {
                  setState(() {
                    cityError = "";
                  });
                }
                if (locality == '') {
                  isValidate = false;
                  setState(() {
                    locationError = "* Location can not be empty.";
                  });
                } else {
                  setState(() {
                    locationError = "";
                  });
                }
                if (isValidate) {
                  String requestBody = "mutation{" +
                      "createUser(" +
                      "userInput:" +
                      "{" +
                      "firstName:\"" +
                      fNameController.text +
                      "\"," +
                      "lastName:\"" +
                      lNameController.text +
                      "\"," +
                      "city:\"" +
                      cityController.text +
                      "\"," +
                      "locality:\"" +
                      locationController.text +
                      "\"," +
                      "mobileNo:\"" +
                      mobileNoController.text +
                      "\"," +
                      "isCustomer:" +
                      isCustomer.toString() +
                      "}" +
                      "){" +
                      "firstName," +
                      "lastName," +
                      "mobileNo," +
                      "password," +
                      "city," +
                      "locality" +
                      "}" +
                      "}";
                  //ApiMethods().createUser(requestBody);
                  _showRegistraionDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange[800],
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                "REGISTER ACCOUNT",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: defaultStyle,
                children: <TextSpan>[
                  TextSpan(text: 'Already have an Account? '),
                  TextSpan(
                    text: 'Sign in here',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                            Navigator.pop(context),
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage()))
                          },
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: AnnotatedRegion(
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50),
                      buildRegistationForm(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        value: SystemUiOverlayStyle.light,
      ),
    );
  }

  _showRegistraionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Wrap(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/logo2.png",
                        height: 45,
                        width: 45,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Findaa",
                        style: TextStyle(
                            color: Colors.orange[800],
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset(
                    "images/smsalert.png",
                    height: 240,
                    width: 240,
                  ),
                  Text(
                    "Welcome to Findaa, Your Mobile Number is your User Id" +
                        " and the password is sent to your registered Mobile Number both in SMS and Whatsapp.",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  TextButton(
                    onPressed: () {
                      FindaaData.isCustomer = isCustomer;
                      Navigator.pop(context, true);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OtpVarification()));
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
