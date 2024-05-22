
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shareplateapp/screens/Auth/login.dart';
import 'admin/home.dart';
import 'firebase_options.dart';
import 'screens/Auth/email_login.dart';
import 'screens/Home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
final result=  await Firebase.initializeApp(
   );
    print(result.options);
 // FirebaseAppCheck.instance.activate();
  SharedPreferences.getInstance().then(
    (prefs) {
      runApp(MyApp(prefs: prefs));
    },
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We4Us ',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: _checkUser(),
    );
  }

  _checkUser() {
    if (prefs.getBool('is_verified') != null) {
      if (prefs.getBool('is_verified')!) {
        if (prefs.getString('uid') == 'Xk6fjxY7QmXBWXwqtZJ2sOsPqaa2') {return AdminPage(prefs: prefs);}else{return HomePage(prefs: prefs);}
        
      }
    }
    return LoginScreen(prefs: prefs);
  }
}
