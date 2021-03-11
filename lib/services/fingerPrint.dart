import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vaultplace/screens/home.dart';


class LocalPage extends StatefulWidget {
  LocalPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LocalPageState createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool _canCheckBiometric;

  String authorized = "Not Authorized";

  List<BiometricType> _availableBiometricType ;

  Future<void> _checkBiometric() async {

    bool canCheckBiometric;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometric() async {

    List<BiometricType> availableBiometricType;
    try {
      availableBiometricType =
      await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBiometricType = availableBiometricType;
    });
  }

  Future<void> _authenticate() async {

    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Authenticate for Testing", // message for dialog
        useErrorDialogs: true,// show error in dialog
        stickyAuth: true,// native process
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      authorized = authenticated ? "Authorized" : "Not Authorized";
      if(authenticated) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }
      print(authorized);
    });
  }

  @override
  void initState() {
    _checkBiometric();
_getAvailableBiometric();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}