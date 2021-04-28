import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:foresee_cycles/utils/styles.dart';
import 'package:foresee_cycles/pages/auth/login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  String name, phone, email, password;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future <void> signUp() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          LoginScreen()));
      print ("User: $userCredential");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbar('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackbar('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void showSnackbar(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFFffebbb),
              Color(0xFFfbceac),
              Color(0xFFf48988),
              Color(0xFFef6786),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.07,
              right: screenSize.width * 0.07,
            ),
            child: Container(
              height: screenSize.height * 0.66,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Let\'s Get Started',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:  screenSize.width * 0.085
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.all(screenSize.height * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenSize.height * 0.01,
                              top: screenSize.height * 0.01,
                            ),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            shadowColor: CustomColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              onSaved: (input) {
                                setState(() {
                                  name = input;
                                });
                                print('Name: $input');
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Name',
                                prefixIcon: Icon(Icons.person_outline),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenSize.height * 0.01,
                              top: screenSize.height * 0.01,
                            ),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            shadowColor: CustomColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              onSaved: (input) {
                                setState(() {
                                  phone = input;                                                                
                                });
                                print('Phone: $input');
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Phone',
                                prefixIcon: Icon(Icons.phone_android_outlined),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenSize.height * 0.01,
                              top: screenSize.height * 0.01,
                            ),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            shadowColor: CustomColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              onSaved: (input) {
                                setState(() {
                                  email = input;                                                                  
                                });
                                print('Email: $input');
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.alternate_email),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              validator: (input) => input.isEmpty
                                  ? 'Email field cannot be empty!'
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenSize.height * 0.01,
                              top: screenSize.height * 0.02,
                            ),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.black
                              ),
                            ),
                          ),
                          Material(
                            elevation: 5.0,
                            shadowColor: CustomColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              onSaved: (input) {
                                setState(() {
                                  password = input;                                                                  
                                });
                                print('Password: $input');
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,                                
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline_rounded),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _toggleVisibility = !_toggleVisibility;
                                    });
                                  },
                                  icon: _toggleVisibility
                                    ? Icon(Icons.visibility_off,
                                        color: CustomColors.greyColor,
                                      )
                                    : Icon(Icons.visibility,
                                        color: CustomColors.greyColor,
                                    ),
                                ),
                              ),
                              obscureText: _toggleVisibility,
                              validator: (input) => input.isEmpty
                                ? 'Password field cannot be empty!'
                                : null,
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                    child: GestureDetector(
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: CustomColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Text(
                            'signup'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.width * 0.06,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if(validateAndSave()){
                          print("userDetails : $name , $phone , $email, $password");
                          await signUp();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ? ',
                        // style: CustomStyle.textStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          'login'.toUpperCase(),
                          style: TextStyle(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                              LoginScreen()));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}