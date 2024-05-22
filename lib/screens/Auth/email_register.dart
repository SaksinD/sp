import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../data/save.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/loading_dialog.dart';
import '../Home/home.dart';

class EmailRegisterPage extends StatefulWidget {
  final SharedPreferences prefs;
 

  const EmailRegisterPage({Key? key, required this.prefs, })
      : super(key: key);

  @override
  State<EmailRegisterPage> createState() => _EmailRegisterUserState();
}

class _EmailRegisterUserState extends State<EmailRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  String _name = '', _gender = 'Male', _uType = 'Helper', _address = '',_email='',_password='',_cPassword='',_phoneNumer='';
String imageurl='';
TextEditingController nameController =TextEditingController();
TextEditingController emailController =TextEditingController();
TextEditingController passController =TextEditingController();
TextEditingController cPassController =TextEditingController();
TextEditingController addController =TextEditingController();
TextEditingController phoneController =TextEditingController();
  Future<void> signUpFormValidation(BuildContext context) async {
    //checking if user selected image
    if (image == null) {
      setState(
        () {
          image=File('images/upload.png');
           showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Please select an image",
              );
            },
          );
        },
      );
    } else {
      if (cPassController.text == passController.text) {
        //nested if (cheking if controllers empty or not)
        if (cPassController.text.isNotEmpty &&
            passController.text.isNotEmpty &&
           nameController.text.isNotEmpty) {
          //start uploading image
          showDialog(
            context: context,
            builder: (c) {
              return const LoadingDialog(
                message: "Registering Account",
              );
            },
          );

          
          // fStorage.Reference reference = fStorage.FirebaseStorage.instance
          //     .ref()
          //     .child("users")
          //     .child(fileName);
          // fStorage.UploadTask uploadTask =
          //     reference.putFile(File(image!.path));
          // fStorage.TaskSnapshot taskSnapshot =
          //     await uploadTask.whenComplete(() {});
          // await taskSnapshot.ref.getDownloadURL().then((url) {
          //   imageurl = url;

          //   // save info to firestore
            
          // });
          Future.delayed(Duration(milliseconds: 500)).then((value) {
            try{AuthenticateSellerAndSignUp(context);}catch(e){
              print(e);
            }

          });
          
        }
        //if there is empty place show this message
        else {
          showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Please fill the required info for Registration. ",
              );
            },
          );
        }
      } else {
        //show an error if passwords do not match
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Password do not match",
            );
          },
        );
      }
    }
  }
final FirebaseAuth auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  void AuthenticateSellerAndSignUp(BuildContext context) async {

    
    User? currentUser;
    await auth
        .createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    )
        .then((auth) {
      currentUser = auth.user;
    })
    .catchError(
      (error) {
        print(error);
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          },
        );
      },
    );

    if (currentUser != null) {
      setState(() {
        
      });
       await saveUserData(
                  context: context,
                  prefs: widget.prefs,
                  uname: _name,
                  ugender: _gender,
                  uType: _uType,
                  uaddress: _address,
                  phoneNo: _phoneNumer,
                  uimage: image, email: _email);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
               Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(prefs: widget.prefs),
                  ),
                  (route) => false);
    }
  }
  Future<void> pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
      if (image == null) return;
      final imagePermanent = await saveImagePermanent(image.path);
      setState((() => this.image = imagePermanent));
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {}
  }

  Future<File> saveImagePermanent(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Widget _userProfile(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ImageProvider<Object>? backgroundImage = image != null
        ? FileImage(image!)
        : AssetImage('images/upload.png') as ImageProvider;
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                  radius: size.width * 0.25, backgroundImage: backgroundImage),
              Container(
                alignment: Alignment.bottomRight,
                width: size.width * 0.5,
                height: size.height * 0.3,
                child: IconButton(
                  icon: Icon(CupertinoIcons.photo_camera_solid,
                      size: size.width * 0.12),
                  onPressed: () => pickImage(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userName(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
        child: TextFormField(
          controller: nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Your Name';
            } else {
              setState(() {
                _name = value;
              });
              
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Enter Your Name', icon: Icon(Icons.person)),
        ),
      ),
    );
  }
 Widget _emailField(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
        child: TextFormField(
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Your Email';
            } else {
             setState(() {
                _email = value;
             });
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Enter Your Email', icon: Icon(Icons.email)),
        ),
      ),
    );
  }
Widget _passWordField(BuildContext context,String pass,TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
        child: TextFormField(
         controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Password';
            } else {
              setState(() {
                pass = value;
              });
              
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Enter Your Password', icon: Icon(Icons.lock)),
              obscureText: true,
        ),
      ),
    );
  }
Widget _phoneNumberField(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
        child: TextFormField(
          controller: phoneController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Phone Number';
            } else {
             setState(() {
                _phoneNumer = value;
             });
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Enter Your Phone Number', icon: Icon(Icons.phone)),
        ),
      ),
    );
  }
 
  Widget _userAddress(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.0, right: size.width * 0.0),
        child: TextFormField(
          controller: addController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Your Address';
            } else {
              setState(() {
                 _address = value;
              });
             
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: 'Enter Your Address',
              icon: Icon(Icons.location_city_rounded)),
        ),
      ),
    );
  }

  Widget _userGender(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'Choose Your Gender',
          style: TextStyle(fontSize: 17, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.arrow_forward_ios, color: Colors.grey[500]),
            SizedBox(width: 10),
            ToggleSwitch(
              totalSwitches: 3,
              labels: ['Male', 'Female', 'Others'],
              icons: [Icons.male, Icons.female, Icons.call_split_rounded],
              cornerRadius: 30,
              minWidth: size.width * 0.28,
              minHeight: size.height * 0.06,
              onToggle: (index) {
                 _gender = index == 0
                    ? 'Male'
                    : index == 1
                        ? 'Female'
                        : 'Others';
                setState(() {
                  
                });
               
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _userType(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'Who are You',
          style: TextStyle(fontSize: 17, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.arrow_forward_ios, color: Colors.grey[500]),
            SizedBox(width: 10),
            ToggleSwitch(
              totalSwitches: 2,
              labels: ['Helper', 'Needy'],
              icons: [
                CupertinoIcons.brightness_solid,
                CupertinoIcons.building_2_fill
              ],
              cornerRadius: 30,
              minWidth: size.width * 0.42,
              minHeight: size.height * 0.06,
              onToggle: (index) {
                 _uType = index == 0 ? 'Helper' : 'Needy';
                setState(() {
                 
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: Colors.deepPurple,
      ),
      child: Center(
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
           await  signUpFormValidation(context);
            }
          },
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _userForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            _emailField(context),
            SizedBox(height: size.height * 0.03),
            _userName(context),
            SizedBox(height: size.height * 0.03),
            _userAddress(context),
            SizedBox(height: size.height * 0.03),
            _phoneNumberField(context),
            _passWordField(context,_password,passController),
              _passWordField(context,_cPassword,cPassController),

            _userType(context),
            SizedBox(height: size.height * 0.03),
            _userGender(context),
            SizedBox(height: size.height * 0.03),
            _submitButton(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Your Information"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        children: [
          _userProfile(context),
          _userForm(context),
        ],
      )),
    );
  }
}
