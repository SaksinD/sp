import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../data/save.dart';
import '../screens/Foods/thank.dart';

class ShareForm extends StatefulWidget {
  final String ftype;
  final SharedPreferences prefs;
  const ShareForm({Key? key, required this.ftype, required this.prefs})
      : super(key: key);
  @override
  _ShareFormState createState() => _ShareFormState();
}

class _ShareFormState extends State<ShareForm> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  int? _foodtype = 1;
  int? _foodlevel = 1;
  String _foodname = '';
  String _foodplace = '';
  DateTime? _fooddatetime;
  File? image;

TextEditingController foodNameController=TextEditingController();
TextEditingController addressController=TextEditingController();
  Future<void> showLoading(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.42, horizontal: size.width * 0.4),
            child: Container(child: const CircularProgressIndicator()),
          );
        });
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 25);
      if (image == null) return;
      final imagePermanent = await saveImagePermanent(image.path);
      setState((() => this.image = imagePermanent));
    } catch (e) {}
  }

  Future<File> saveImagePermanent(String imagePath) async {
    Directory directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Future<void> _imgSrc(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose source of image'),
            content: SizedBox(
              width: 60,
              height: 120,
              child: Column(children: [
                ListTile(
                  title: const Text('Camera'),
                  leading: const Icon(CupertinoIcons.camera_fill),
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Gallery'),
                  leading: const Icon(CupertinoIcons.folder_solid),
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
              ]),
            ),
          );
        });
  }

  Widget _foodImage(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ImageProvider<Object>? backgroundImage = image != null
        ? FileImage(image!)
        : const AssetImage('images/upload.png') as ImageProvider;
    return Column(
      children: [
        const SizedBox(height: 10),
        Center(
          child: Stack(
            children: [
              SizedBox(
                width: size.width * 0.5,
                height: size.height * 0.25,
                child: CircleAvatar(
                    radius: size.width * 0.25,
                    backgroundImage: backgroundImage),
              ),
              Container(
                  alignment: Alignment.bottomRight,
                  width: size.width * 0.5,
                  height: size.height * 0.25,
                  child: IconButton(
                    icon: Icon(CupertinoIcons.upload_circle_fill,
                        size: size.width * 0.12),
                    onPressed: () => _imgSrc(context),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _foodName(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        child: TextFormField(
          controller: foodNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Item Name';
            } else {
              _foodname = value;
            }
            return null;
          },
          decoration: const InputDecoration(
              labelText: 'Enter Name of Item',
              icon: Icon(
                Icons.food_bank_rounded,
              )),
        ),
      ),
    );
  }

  Widget _foodPlace(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        child: TextFormField(
          controller: addressController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Place of Item';
            } else {
              _foodplace = value;
            }
            return null;
          },
          decoration: const InputDecoration(
              labelText: 'Enter Item Place',
              icon: Icon(
                Icons.place_outlined,
              )),
        ),
      ),
    );
  }

  Widget _foodDateTime(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 900,
      child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        child: DateTimeField(
          decoration: const InputDecoration(
              labelText: 'Enter Duration of Item is with You',
              icon: Icon(Icons.timelapse_outlined)),
          validator: (value) {
            if (value == null) {
              return 'Please Enter Duration';
            }
            return null;
          },
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
          onChanged: (value) {
            _fooddatetime = value;
          },
        ),
      ),
    );
  }

  Widget _foodTye(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 900,
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.05, right: size.width * 0.05),
          child: Column(
            children: [
              Text(
                'Choose The State of Item',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(children: [
                    Icon(CupertinoIcons.arrow_right_square,
                        size: 25, color: Colors.grey[500]),
                    Radio(
                        value: 1,
                        groupValue: _foodtype,
                        onChanged: (val) {
                          setState(() {
                            _foodtype = val as int;
                          });
                        }),
                    const SizedBox(width: 10.0),
                    const Text('Solid / Firm')
                  ]),
                  const SizedBox(width: 30),
                  Row(children: [
                    Icon(CupertinoIcons.arrow_right_square,
                        size: 25, color: Colors.grey[500]),
                    Radio(
                        value: 2,
                        groupValue: _foodtype,
                        onChanged: (val) {
                          setState(() {
                            _foodtype = val as int;
                          });
                        }),
                    const SizedBox(width: 10.0),
                    const Text('Liquid / Fluid'),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _foodLevel(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 900,
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.05, right: size.width * 0.05),
          child: Column(
            children: [
              Text(
                'Choose The Quantity of Item ',
                style: TextStyle(fontSize: 17, color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(CupertinoIcons.arrow_right_square,
                      size: 27, color: Colors.grey[500]),
                  const SizedBox(width: 5),
                  for (int i = 1; i <= 6; i++)
                    Column(
                      children: [
                        Radio(
                          value: i,
                          groupValue: _foodlevel,
                          onChanged: (val) {
                            setState(() {
                              _foodlevel = val as int;
                            });
                          },
                        ),
                        if (i <= 5) Text('$i') else Text('$i +')
                      ],
                    ),
                ],
              ),
              // add slider.......
            ],
          ),
        ),
      ),
    );
  }

  Widget _shareButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          
            showLoading(context);
            await saveFoodData(
                    context: context,
                    prefs: widget.prefs,
                    fname: foodNameController.text.trim(),
                    ftype: widget.ftype,
                    fstate: _foodtype!,
                    fplace: addressController.text.trim(),
                    ftime: _fooddatetime,
                    fnum: _foodlevel,
                    fimage: image)
                .then((value) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ThankYouPage(
                          encodeData: 'Thanks For Sharing Your Meal')));
            });
          
        },
        child: const Text(
          'Share Food / Item',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _foodImage(context),
            const SizedBox(height: 15),
            _foodName(context),
            const SizedBox(height: 15),
            _foodPlace(context),
            const SizedBox(height: 15),
            _foodDateTime(context),
            const SizedBox(height: 15),
            _foodTye(context),
            const SizedBox(height: 15),
            _foodLevel(context),
            const SizedBox(height: 15),
            _shareButton(context),
          ],
        ));
  }
}
