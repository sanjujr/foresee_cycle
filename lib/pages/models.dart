import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String name;
  String mbNo;
  String email;
  int periodDays;
  UserData({this.name, this.mbNo, this.email, this.periodDays});
}

UserData userdata = new UserData(
    name: 'Julianne Hough',
    mbNo: '+91 9061 157 246',
    email: 'juliannehough29@gmail.com',
    periodDays: 4);
