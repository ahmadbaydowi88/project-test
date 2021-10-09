import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:fan_test/auth/sign_up.dart';
import 'package:fan_test/home/home.dart';
import 'package:fan_test/widget/public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool sedangMasuk = false;
  bool showpassword = false;
  bool initComplete = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: showpassword,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                showpassword = !showpassword;
              });
            },
            child: Icon(showpassword ? Icons.visibility : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginBottom = ArgonButton(
      height: 50,
      width: MediaQuery.of(context).size.width,
      borderRadius: 8,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.login, color: Colors.white),
          SizedBox(
            width: 3,
          ),
          Text(
            "Login",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      roundLoadingShape: false,
      minWidth: MediaQuery.of(context).size.width,
      loader: SpinKitThreeBounce(color: Colors.white, size: 30),
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          signIn(emailController.text, passwordController.text);
        }
      },
    );

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.1,
            0.8,
          ],
              colors: [
            Colors.blue.withBlue(80).withOpacity(0.9),
            Colors.yellow.withBlue(80).withOpacity(0.9),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: AbsorbPointer(
            absorbing: sedangMasuk,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.asset(
                      "assets/fan.png",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "selamat Datang",
                      textAlign: TextAlign.center,
                      style: TextStyle().copyWith(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      borderOnForeground: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            emailField,
                            SizedBox(
                              height: 10.0,
                            ),
                            passwordField,
                            SizedBox(
                              height: 10.0,
                            ),
                            loginBottom,
                          ],
                        ),
                      ),
                    ),
                    _footer(),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  Widget _footer() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Belum punya Akun?',
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => SignUpPage(),
            )),
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
