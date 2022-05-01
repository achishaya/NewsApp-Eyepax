import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/models/user.dart';
import 'package:news_app_api/views/homepage.dart';
import 'package:news_app_api/views/login/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;

  String _email, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  Future<void> getValues() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    getValues();
    setState(() {

    });
    super.initState();
  }

  showAlertDialog(BuildContext context, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text('Login Error'),
      content: Text(message),
      elevation: 10,
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
      barrierDismissible: true,
    );
  }

  void _register() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => RegisterPage()));
  }

  void _submit() {
      final form = formKey.currentState;
      if (form.validate()) {
        setState(() {
          _isLoading = true;
          form.save();
          _presenter.doLogin(_email, _password);
        });
      }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
      ),
      onPressed: _submit,
      child: Text("Login"),
    );
    var registerBtn = GestureDetector(
      onTap: _register,
      child:  Text("Register", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
    );
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          child: Image.asset('images/news.png'),
        ),
        SizedBox(height: 40,),
        Form(
          key: formKey,
          child:  Column(
            children: <Widget>[
               Container(
                 width:MediaQuery.of(context).size.width - 50,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextFormField(
                  onSaved: (val) => _email = val,
                  decoration: InputDecoration(
                    hintText: 'E - Mail',
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width:MediaQuery.of(context).size.width - 50,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40,),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: loginBtn),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Do not have an account ? '),
            registerBtn,
          ],
        )
      ],
    );

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    showAlertDialog(context, 'Invalid E - Mail or Password');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if(user.username == ""){
//      _showSnackBar("Login not successful");
      showAlertDialog(context, 'Invalid E - Mail or Password');
    }else{
      showAlertDialog(context, 'Invalid E - Mail or Password');
    }
    setState(() {
      _isLoading = false;
    });
    if(user.flaglogged == "logged"){
      print("Logged");
      sharedPreferences.setString('loggedUser', 'true');
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage()
      ));
    }else{
      print("Not Logged" + _password);
    }
  }
}
