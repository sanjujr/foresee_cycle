import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foresee_cycles/utils/constant_data.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

import 'package:foresee_cycles/pages/auth/login.dart';
import 'package:foresee_cycles/pages/home/appbar.dart';
import 'package:foresee_cycles/pages/home/chat_widget.dart';
import 'package:foresee_cycles/pages/home/note_widget.dart';
import 'package:foresee_cycles/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool isCalender = false,
    isChat = false,
    isHome = true,
    isProfile = false,
    isNote = false;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomeBody(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        height: 70,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4],
              colors: [
                Color(0xFFf48988),
                Color(0xFFef6786),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20, color: Colors.grey[400], spreadRadius: 1)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isCalender = true;
                    isChat = false;
                    isHome = false;
                    isProfile = false;
                    isNote = false;
                  });
                },
                child:
                    buildContainerBottomNav(Icons.calendar_today, isCalender),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCalender = false;
                    isChat = true;
                    isHome = false;
                    isProfile = false;
                    isNote = false;
                  });
                },
                child: buildContainerBottomNav(Icons.message, isChat),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCalender = false;
                    isChat = false;
                    isHome = true;
                    isProfile = false;
                    isNote = false;
                  });
                },
                child: buildContainerBottomNav(Icons.home, isHome),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCalender = false;
                    isChat = false;
                    isHome = false;
                    isProfile = false;
                    isNote = true;
                  });
                },
                child: buildContainerBottomNav(Icons.note_add, isNote),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCalender = false;
                    isChat = false;
                    isHome = false;
                    isProfile = true;
                    isNote = false;
                  });
                },
                child: buildContainerBottomNav(Icons.person, isProfile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomeBody extends StatefulWidget {
  @override
  _MyHomeBodyState createState() => _MyHomeBodyState();
}

class _MyHomeBodyState extends State<MyHomeBody> {
  Container homeWidget(BuildContext context) {
    return Container(
      child: Column(
        children: [
          customAppBar(context, "Home"),
          homeBodyWidget(context),
        ],
      ),
    );
  }

  Expanded homeBodyWidget(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: InkWell(
            splashColor: Colors.white,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.3),
            onTap: () {
              setState(() {
                isCalender = true;
                isChat = false;
                isHome = false;
                isProfile = false;
                isNote = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 0.7],
                  colors: [
                    Color(0xFFfbceac),
                    Color(0xFFf48988),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "Last Period",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "Mar 1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "21 days ago",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container calenderWidget(BuildContext context) {
    return Container(
      child: Column(
        children: [
          customAppBar(context, "Calendar"),
          calenderBodyWidget(context)
        ],
      ),
    );
  }

  DateTime _currentDate;

  Expanded calenderBodyWidget(BuildContext context) {
    return Expanded(
      child: CalendarCarousel(
        onDayPressed: (DateTime date, List events) {
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: CustomColors.primaryColor,
        ),
        thisMonthDayBorderColor: Colors.white,
        weekFormat: false,
        height: MediaQuery.of(context).size.height * 0.6,
        selectedDateTime: _currentDate,
        selectedDayButtonColor: Colors.white,
        selectedDayBorderColor: CustomColors.primaryColor,
        selectedDayTextStyle: TextStyle(color: Colors.black),
        daysHaveCircularBorder: true,
        isScrollable: false,
        todayButtonColor: CustomColors.primaryColor,
      ),
    );
  }

  Container profileWidget(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          color: CustomColors.secondaryColor,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => {},
                      child: Text(
                        'Edit',
                        style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 110,
          left: 14,
          right: 14,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              elevation: 3,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.085,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage(ConstantsData.userImage))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Julianne Hough",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "+91 9061 157 246",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "juliannehough29@gmail.com",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 14, right: 14),
          child: Card(
            elevation: 3,
            semanticContainer: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: ListView(
              padding: EdgeInsets.only(top: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: InkWell(
                    onTap: () {

                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          size: 22,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Account Settings',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 15),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Theme.of(context).disabledColor,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Divider(
                  indent: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: InkWell(
                    onTap: () {
                      
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.language,
                          size: 22,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Select your Language',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 15),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Theme.of(context).disabledColor,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Divider(
                  indent: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: InkWell(
                    onTap: () async {
                      print("logout");
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                      LoginScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: 26,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Logout',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontSize: 15),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Theme.of(context).disabledColor,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Divider(
                  indent: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return isCalender
        ? calenderWidget(context)
        : isChat
            ? chatWidget(context)
            : isHome
                ? homeWidget(context)
                : isNote
                    ? noteWidget(context)
                    : profileWidget(context);
  }
}

Container buildContainerBottomNav(IconData icon, bool isSelected) {
  return Container(
    decoration: BoxDecoration(
      color: isSelected ? Colors.white : null,
      shape: BoxShape.circle,
      boxShadow: isSelected
          ? [BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1)]
          : [],
    ),
    height: 50,
    width: 50,
    child: Icon(icon,
        color: isSelected ? CustomColors.primaryColor : Colors.white),
  );
}
