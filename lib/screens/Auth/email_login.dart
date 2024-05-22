// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../admin/home.dart';
// import '../../widgets/error_dialog.dart';
// import '../../widgets/loading_dialog.dart';
// import '../Home/home.dart';
// import 'email_register.dart';
// import 'register.dart';

// class EmailLogin extends StatefulWidget {
//   final SharedPreferences prefs;

//   const EmailLogin({Key? key, required this.prefs}) : super(key: key);
//   @override
//   _EmailLoginState createState() => _EmailLoginState();
// }

// class _EmailLoginState extends State<EmailLogin> {
//   String phoneNo = " ";
//   String smsOTP = '';
//   String verificationId = '';
//   String errorMessage = '';
//   bool changeButton = false;
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final db = FirebaseFirestore.instance;
//  String _email='';
//  String _password='';

//  loginNow() async {
//      showDialog(
//       context: context,
//       builder: (c) {
//         return const LoadingDialog(
//           message: "Checking Credentials...",
//         );
//       },
//     );

//     User? currentUser;
//     await auth
//         .signInWithEmailAndPassword(
//       email: _email.trim(),
//       password: _password.trim(),
//     )
//         .then(
//       (auth) {
//         currentUser = auth.user!;
//         widget.prefs.setString('uid', currentUser!.uid);
//       },
//     ).catchError((error) {
//       Navigator.pop(context);
//       showDialog(
//         context: context,
//         builder: (c) {
//           return ErrorDialog(
//             message: error.message.toString(),
//           );
//         },
//       );
//     });
//     if (currentUser != null) {
//       widget.prefs.setBool('is_verified', true);
//     if  (currentUser!.uid == 'admin') {
//           widget.prefs.setString('uid', currentUser!.uid);
         
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => AdminPage(prefs: widget.prefs)),
//               (route) => false);}
//               else{
//                  getData(db, widget.prefs);
//                   Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => HomePage(prefs: widget.prefs),
//                   ),
//                   (route) => false);
//               }
     
//     }
//   }
//   @override
//   initState() {
//     super.initState();
//   }

 
//   Future<void> getData(dynamic db, SharedPreferences prefs) async {
//     DocumentSnapshot data =
//         await db.collection('users').doc(prefs.getString('uid')).get();
//     if (data.exists) {
//       Map<String, dynamic> userData = data.data() as Map<String, dynamic>;
//       setState(() {
//         prefs.setString('name', userData['name']);
//         prefs.setString('email', userData['email']);
//         prefs.setString('gender', userData['gender']);
//         prefs.setString('type', userData['type']);
//         prefs.setString('address', userData['address']);
//         prefs.setString('profImg', userData['profileImg']);
//         prefs.setString('phone', userData['phone']);
//         prefs.setInt('gift', userData['gift']);
//         prefs.setBool('is_verified', true);
//       });
//     }
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   _Banner(),
//                   _emailField(context),
//                   _passWordField(context),
//                   //  (errorMessage != ''
//                   //     ? Text(
//                   //         errorMessage,
//                   //         style: const TextStyle(color: Colors.red),
//                   //       )
//                   //     : Container()),
//                   // SizedBox(
//                   //   height: 15.0,
//                   //   width: 30.0,
//                   // ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(size.width * 0.2, 0.0,
//                         size.width * 0.2, size.height * 0.05),
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         loginNow();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.deepPurple,
//                         disabledForegroundColor: Colors.grey.withOpacity(0.38),
//                         disabledBackgroundColor: Colors.grey.withOpacity(0.12),
//                         minimumSize: Size(size.width * 0.5, size.height * 0.07),
//                       ),
//                       child: const Text('Login'),
//                     ),
//                   ),
//                GestureDetector(
//                 onTap: (){
// Navigator.push(context, MaterialPageRoute(builder: (_)=>EmailRegisterPage(prefs: widget.prefs,)));
//                 },
//                 child: Text('i dont have account?Register now',style: TextStyle(color: Colors.black),))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _emailField(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       alignment: Alignment.center,
//       width: 900,
//       child: Padding(
//         padding:
//             EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
//         child: TextFormField(
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please Enter Your Email';
//             } else {
//               _email = value;
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//               labelText: 'Enter Your Email', icon: Icon(Icons.email)),
//         ),
//       ),
//     );
//   }
// Widget _passWordField(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       alignment: Alignment.center,
//       width: 900,
//       child: Padding(
//         padding:
//             EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
//         child: TextFormField(
         
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please Enter Password';
//             } else {
//               _password = value;
//             }
//             return null;
//           },
//           decoration: InputDecoration(
//               labelText: 'Enter Your Password', icon: Icon(Icons.lock)),
//               obscureText: true,
//         ),
//       ),
//     );
//   }

// }

// class _Banner extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const SizedBox(height: 40),
//           Text(
//             'We4Us ',
//             style: TextStyle(
//               fontSize: size.width * 0.1,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Image.asset(
//             "images/login.png",
//             width: size.width,
//             height: size.height * 0.5,
//           )
//         ],
//       ),
//     );
//   }
// }
