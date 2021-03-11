import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vaultplace/screens/home.dart';
import 'package:vaultplace/services/auth.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Login({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
//////////////////////////////////

  // final LocalAuthentication _localAuthentication = LocalAuthentication();
  //
  // bool _canCheckBiometric;
  //
  // String authorized = "Not Authorized";
  //
  // List<BiometricType> _availableBiometricType ;
  //
  // Future<void> _checkBiometric() async {
  //
  //   bool canCheckBiometric;
  //   try {
  //     canCheckBiometric = await _localAuthentication.canCheckBiometrics;
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _canCheckBiometric = canCheckBiometric;
  //   });
  // }
  //
  // Future<void> _getAvailableBiometric() async {
  //
  //   List<BiometricType> availableBiometricType;
  //   try {
  //     availableBiometricType =
  //     await _localAuthentication.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _availableBiometricType = availableBiometricType;
  //   });
  // }
  //
  // Future<void> _authenticate() async {
  //
  //   bool authenticated = false;
  //   try {
  //     authenticated = await _localAuthentication.authenticateWithBiometrics(
  //       localizedReason: "Authenticate for Testing", // message for dialog
  //       useErrorDialogs: true,// show error in dialog
  //       stickyAuth: true,// native process
  //     );
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     authorized = authenticated ? "Authorized" : "Not Authorized";
  //     if(authenticated) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  //     }
  //     print(authorized);
  //   });
  // }
  //
  // @override
  // void initState() {
  //   _checkBiometric();
  //   _getAvailableBiometric();
  //   //super.initState();
  // }

  ///////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: const ValueKey("username"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Username"),
                  controller: _emailController,
                ),
                TextFormField(
                  obscureText: true,
                  key: const ValueKey("password"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  key: const ValueKey("signIn"),
                  onPressed: () async {
                    final String retVal = await Auth(auth: widget.auth).signIn(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (retVal == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(retVal),
                        ),
                      );
                    }
                  },
                  child: const Text("Sign In"),
                ),
                // FlatButton(
                //   key: const ValueKey("createAccount"),
                //   onPressed: () async {
                //     final String retVal =
                //         await Auth(auth: widget.auth).createAccount(
                //       email: _emailController.text,
                //       password: _passwordController.text,
                //     );
                //     if (retVal == "Success") {
                //       _emailController.clear();
                //       _passwordController.clear();
                //     } else {
                //       Scaffold.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(retVal),
                //         ),
                //       );
                //     }
                //   },
                //   child: const Text("Create Account"),
                // )
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                    icon: Icon(
                        Icons.fingerprint,),
                     iconSize: 60,
                    onPressed: () {

                      // _authenticate;
                    }),

                // InkWell(
                //   child: ListTile(
                //     onTap: () {},
                //     //title: Text('fingerprint'),
                //     leading: Icon(Icons.fingerprint),
                //   ),
                // ),

                //     Image.asset('assets/fingerprint.jpg',
                //       fit: BoxFit.cover,
                //       width: 120.0,
                // child: InkWell(
                // onTap: () { /* ... */ },
                // )
                //     ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
