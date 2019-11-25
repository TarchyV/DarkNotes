import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/services/authentication.dart';
class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _errorMessage = " ";
final databaseReference = Firestore.instance;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;
  bool _selected = false;
  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = " ";
      _isLoading = true;
      _selected = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          createRecord(userId);
          _showVerifyEmailSentDialog();
          userId = await widget.auth.signIn(_email, _password);
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }

      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.toString().substring(e.toString().indexOf(',') + 1, e.toString().lastIndexOf(','));
          } else
            _errorMessage = e.toString().substring(e.toString().indexOf(',') + 1, e.toString().lastIndexOf(','));
        });
      }
    }
  }

void createRecord(String uid) async {
await databaseReference.collection('Users')
.document(uid)
.setData({
'noteCount': 0
});


}




  @override
  void initState() {
    _errorMessage = " ";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }
@override
  void dispose() {  
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.black             
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,0,0),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/Logo.png',
                  fit: BoxFit.contain,)
                   ,),
              ),
             _selected ? Stack(children: <Widget>[
                Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: _showBody(),
              ),
              _showCircularProgress(),
              ],):
              Container(

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,80,20,0),
                    child: Column(children: <Widget>[
                      Container(
                        width: 300,
                      decoration: new BoxDecoration(
                            color: Colors.black45,
                        border: Border.all(color: Colors.white24, width: 2),
                        borderRadius: BorderRadius.circular(12)
                      ),

                        child: FlatButton(
                          onPressed: (){
                              setState((){
                              _selected = true;
                              _formMode = FormMode.LOGIN;
                              });
                          },
                          child: Text('Login', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 28),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          width: 300,
                          decoration: new BoxDecoration(
                            color: Colors.black45,
                            border: Border.all(color: Colors.white24, width: 2),
                            borderRadius: BorderRadius.circular(12)

                          ),
                          child: FlatButton(
                            onPressed: (){
                              setState((){
                              _selected = true;
                              _formMode = FormMode.SIGNUP;
                              });

                            },
                            child: Text('Create Account', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 26),),
                          ),
                        ),
                      )
                    ],),
                  ),

              )
              
            ],
          ),
        ));
  }

  Widget _showCircularProgress(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
    } return Container(height: 0.0, width: 0.0,);

  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody(){
    return new Container(
      height: 800,
        padding: EdgeInsets.all(8.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
          // shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:60.0),
                child: Container(                 
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white54
                  ),
                  child: Column(
                  children: <Widget>[
                _showEmailInput(),
                _showPasswordInput(),
               
                ],),),
              ),
              _showPrimaryButton(),
                _showSecondaryButton(),
              Center(child: Text(_errorMessage.toString(), style: TextStyle(fontSize: 13, color: Colors.red, height: 1.0, fontWeight: FontWeight.w300),)),
            ],
          ),
        ));
  }


  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          fillColor: Colors.red,
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.black,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.black,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0,color: Colors.white, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.white)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
            color: Colors.white,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w800)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}