import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foresee_cycles/pages/auth/login.dart';
import 'package:foresee_cycles/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
        backgroundColor: CustomColors.primaryColor,
        brightness: Brightness.light,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: CustomColors.secondaryColor,),
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  LoginScreen()));
              print("Signed Out");
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}