import 'package:flutter/material.dart';
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
      ),
      drawer: Drawer(elevation: 5,),
      body: Container(
        child: Center(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}