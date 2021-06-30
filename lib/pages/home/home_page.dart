import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart' as prefix;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:foresee_cycles/pages/models.dart';
import 'package:foresee_cycles/utils/constant_data.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:intl/intl.dart';
import 'package:foresee_cycles/pages/auth/login.dart';
import 'package:foresee_cycles/pages/home/appbar.dart';
import 'package:foresee_cycles/pages/home/chat_widget.dart';
import 'package:foresee_cycles/pages/home/note_widget.dart';
import 'package:foresee_cycles/utils/styles.dart';
// import 'package:cloud_firestore/cloud_firestore.dart ';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool isCalender = false,
    isChat = false,
    isHome = true,
    isProfile = false,
    isNote = false;
int periodDays = userdata.periodDays;
DateTime _currentDate;
Timestamp _startTimeStamp;
List<DateTime> dates;
// DateTime _endDate;

FirebaseFirestore firestore = FirebaseFirestore.instance;
EventList<Event> _markedDates;
AsyncSnapshot<QuerySnapshot> streamSnapshot;

class _HomeScreenState extends State<HomeScreen> {
  List documents;

  Future setData() async {
    streamSnapshot = AsyncSnapshot.nothing();
    if (!streamSnapshot.hasData) {
      _startTimeStamp = await streamSnapshot.data.docs[0]['start_date'];
    } else {}
    print(_startTimeStamp);
  }

  fetchData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('period_date');

    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        documents = snapshot.docs;
      });
    });

    _markedDates = EventList<Event>(events: {});

    for (int i = 1; i < documents.length; i++) {
      dates = [];
      _startTimeStamp = documents[i]['start_date'];
      var periodDayss = documents[i]['period_days'];
      DateTime _startDate = DateTime.parse(_startTimeStamp.toDate().toString());

      dates.add(_startDate);
      for (int i = 1; i < periodDayss; i++) {
        _startDate = _startDate.add(Duration(days: 1));
        dates.add(_startDate);
      }

      for (int i = 0; i < dates.length; i++) {
        _markedDates.add(
            dates[i],
            new Event(
                date: dates[i],
                title: "Period",
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(dates[i].day.toString()),
                  ),
                )));
        // print(_startDate);
      }
    }
    print(_markedDates);
  }

  @override
  void initState() {
    // FirebaseAuth.instance.signOut();
    _markedDates = EventList<Event>(events: {});
    dates = [];
    setData();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setData(),
      // ),
      body: StreamBuilder(
          stream: firestore.collection('period_date').snapshots(),
          builder: (BuildContext context, streamSnapshot) {
            return streamSnapshot.hasData
                ? MyHomeBody(DateTime.parse(
                    documents[0]['start_date'].toDate().toString()))
                : Text('Loading...');
          }),

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
  final DateTime lastPeriod;
  MyHomeBody(this.lastPeriod);
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

  String formattedDate;
  final today = DateTime.now();
  int difference;

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
                      formattedDate,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "$difference days ago",
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

  calenderBodyWidget(BuildContext context) {
    return
        // StreamBuilder(
        CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List events) {
        this.setState(() => _currentDate = date);
        firestore
            .collection('period_date')
            .doc('date')
            .update({'start_date': _currentDate});
      },
      weekendTextStyle: TextStyle(
        color: CustomColors.primaryColor,
      ),
      markedDatesMap: _markedDates,
      markedDateShowIcon: true,
      markedDateIconBuilder: ((event) => event.icon),
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      thisMonthDayBorderColor: Colors.white,
      weekFormat: false,
      height: MediaQuery.of(context).size.height * 0.6,
      selectedDateTime: _currentDate,
      selectedDayButtonColor: Colors.white,
      // selectedDayBorderColor: CustomColors.primaryColor,
      selectedDayTextStyle: TextStyle(color: Colors.black),
      daysHaveCircularBorder: true,
      isScrollable: false,
      todayButtonColor: Colors.blueAccent,
    );
    // : Center(child: Text('Loading...'));
  }
  //   );
  // }

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
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => {},
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            color: CustomColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                            image: DecorationImage(
                                image: AssetImage(ConstantsData.userImage))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userdata.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              userdata.mbNo,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              userdata.email,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 14,
              right: 14),
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
                    onTap: () {},
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
                    onTap: () {},
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
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

  setDate() {
    formattedDate = DateFormat('MMM dd').format(widget.lastPeriod);
    difference = today.difference(widget.lastPeriod).inDays;
  }

  @override
  void initState() {
    setDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setDate();
    return isCalender
        ?
        // SizedBox()
        calenderWidget(context)
        : isChat
            ? chatWidget(context)
            : isHome
                ? homeWidget(context)
                : isNote
                    ? Notes()
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
