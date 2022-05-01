import 'package:flutter/material.dart';
import 'package:news_app_api/helper/database-helper.dart';
import 'package:news_app_api/models/user.dart';
import 'package:news_app_api/views/login/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage> {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name = '', _username = '', _password = '';



  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
      ),
      onPressed: _submit,
      child: Text("Register"),
    );

    var loginForm = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          child: Image.asset('images/news.png'),
        ),
        SizedBox(height: 40,),
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width:MediaQuery.of(context).size.width - 50,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextFormField(
                  onSaved: (val) => _name = val,
                  onChanged: (val) => _name = val,
                  decoration: InputDecoration(
                      hintText: 'Name',
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
                  onSaved: (val) => _username = val,
                  onChanged: (val) => _username = val,
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
                  onChanged: (val) => _password = val,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none
                  ),
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40,),
        loginBtn
      ],
    );

    return new Scaffold(
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  showAlertDialog(BuildContext context, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text('Registration Error'),
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

  void _submit(){
    final form = formKey.currentState;
    setState(() {});
    print('Username $_name, $_username, $_password');
    if(_name.isEmpty || _username.isEmpty || _password.isEmpty){
      showAlertDialog(context, 'Any Field can not be empty');
    }else{
      if (form.validate()) {
        setState(() {
          _isLoading = true;
          form.save();
          var user = new User(_name, _username, _password, null);
          var db = new DatabaseHelper();
          db.saveUser(user);
          _isLoading = false;
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => LoginPage()));
        });
      }
    }
  }
}