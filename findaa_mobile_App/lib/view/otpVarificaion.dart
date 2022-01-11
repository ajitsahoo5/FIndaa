import 'package:findaa/presenter/data.dart';
import 'package:findaa/view/business_ownerHome.dart';
import 'package:findaa/view/customerHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVarification extends StatefulWidget {
  @override
  _OtpVarificationState createState() => _OtpVarificationState();
}

class _OtpVarificationState extends State<OtpVarification> {
  String otp = "";

  var otpPin = TextEditingController();
  var sixDigitPin = TextEditingController();
  var confirmPin = TextEditingController();

  var sixDigitPinFocus = FocusNode();
  var confirmPinFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 50),
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
                      SizedBox(height: 60),
                      Text(
                        "Enter OTP",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: PinCodeTextField(
                          controller: otpPin,
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          length: 4,
                          obscureText: false,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 45,
                            fieldWidth: 45,
                          ),
                          animationType: AnimationType.scale,
                          keyboardType: TextInputType.number,

                          onCompleted: (v) {
                            print("Completed");
                            sixDigitPinFocus.requestFocus();
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              //currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Enter 6 digits PIN",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: PinCodeTextField(
                          controller: sixDigitPin,
                          focusNode: sixDigitPinFocus,
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',

                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.number,

                          onCompleted: (v) {
                            print("Completed");
                            confirmPinFocus.requestFocus();
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              //currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Re-enter 6 digits PIN",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: PinCodeTextField(
                          controller: confirmPin,
                          focusNode: confirmPinFocus,
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',

                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.number,

                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              //currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!FindaaData.isCustomer) {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BusinessOwnerHome(),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CustomerHome(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "Create PIN",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
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
}
