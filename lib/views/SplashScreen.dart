import 'package:flutter/material.dart';
import 'package:news_app_api/views/homepage.dart';
import 'package:news_app_api/views/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  SharedPreferences sharedPreferences;
  String loggedUser;

  Future<String> getValues() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
    loggedUser = sharedPreferences.get('loggedUser');
    setState(() {

    });
    _splashTimer();
//    print(country);
    return loggedUser;
  }

  @override
  void initState() {
    getValues();
    setState(() {

    });
    super.initState();
  }

  Future<bool> _splashTimer() async {
    await Future.delayed(Duration(milliseconds: 4000), () {});
    navigationPath();
    return true;
  }

  void navigationPath() {
    if(loggedUser == 'true'){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage()));
    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 200,
                            child: Image.asset('images/news.png'),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
