import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/pages/login_page.dart';

class PatientRegisterPage extends StatefulWidget {
  const PatientRegisterPage({super.key});
  static String verify = "";

  @override
  State<PatientRegisterPage> createState() => _PatientRegisterPageState();
}

class _PatientRegisterPageState extends State<PatientRegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  var phone = LoginPage.phoneNum;
  bool showTermsError = false;
  var dataRegister = {
    'fullName': '',
    'phoneNumber': LoginPage.phoneNum,
    'email': '',
  };

  @override
  void initState() {
    countryController.text = "+84";
    super.initState();
    if (LoginPage.phoneNum != null && LoginPage.phoneNum.isNotEmpty) {
      if (LoginPage.phoneNum.startsWith('0')) {
        phoneNumberController.text = LoginPage.phoneNum;
      } else {
        phoneNumberController.text = '0${LoginPage.phoneNum}';
      }
    }
  }

  void _showTermsAndConditionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Terms and Conditions"),
          content: SingleChildScrollView(
            child: Text(
              // Điều khoản và điều kiện của bạn ở đây
              "By using this app, you agree to the terms and conditions...",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage('images/background.jpg'),
              //     fit: BoxFit.cover)),
              ),
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 600,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Register Patient Account',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            prefixIcon: Icon(Icons.people),
                            hintText: 'Fullname',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter your Fullname';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              dataRegister['fullName'] = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            prefixIcon: Icon(Icons.phone),
                            hintText: 'Phone Number',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter your Phone Number';
                            }

                            final String phoneNumber = value ?? "";
                            if (int.tryParse(phoneNumber) == null) {
                              return 'Please enter a valid Phone Number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            var newValue = int.parse(value).toString();
                            setState(() {
                              dataRegister['phoneNumber'] = newValue;

                              phone = newValue;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (value.contains('@')) {
                                return null;
                              } else {
                                return 'Please enter a VALID EMAIL ';
                              }
                            } else {
                              return 'Please enter your EMAIL';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              dataRegister['email'] = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                            Row(
                              children: [
                                Text(
                                  'I Agree with the',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 157, 156, 156),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _showTermsAndConditionsDialog,
                                  child: Text(
                                    'terms and conditions',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          showTermsError
                              ? 'Please agree to the terms and conditions.'
                              : '', // Nếu _isChecked là true, hiển thị chuỗi trống
                          style: TextStyle(
                            color: Color.fromARGB(255, 214, 47, 35),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  // Trong hàm onPressed của nút đăng ký
                                  onPressed: () async {
                                    print(
                                        "countryController.text type: ${countryController.text.runtimeType}");
                                    print("phone type: ${phone.runtimeType}");
                                    print("Data register: $dataRegister");
                                    if (!_isChecked) {
                                      setState(() {
                                        showTermsError = true;
                                      });
                                      _formKey.currentState!.validate();
                                    } else {
                                      setState(() {
                                        showTermsError = false;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        await FirebaseAuth.instance
                                            .verifyPhoneNumber(
                                          phoneNumber:
                                              '${countryController.text + phone}',
                                          verificationCompleted:
                                              (PhoneAuthCredential
                                                  credential) {},
                                          verificationFailed:
                                              (FirebaseAuthException e) {},
                                          codeSent: (String verificationId,
                                              int? resendToken) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Verification code sent!'),
                                            ));
                                            PatientRegisterPage.verify =
                                                verificationId;

                                            // Chuyển dataRegister sang trang verify_register
                                            Navigator.pushNamed(
                                              context,
                                              'verify_register',
                                              arguments: dataRegister,
                                            );
                                          },
                                          codeAutoRetrievalTimeout:
                                              (String verificationId) {},
                                        );
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
