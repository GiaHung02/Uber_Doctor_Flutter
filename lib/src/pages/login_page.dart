import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uber_doctor_flutter/src/controllers/auth/login_controller.dart';
import 'package:uber_doctor_flutter/src/pages/doctor_register_page.dart';
import 'package:uber_doctor_flutter/src/pages/patient_register_page.dart';
import 'package:uber_doctor_flutter/src/pages/verify.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String verify = "";
  static String approle = "";
  static String userid = "";

  static String phoneNum = "";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();
  var phone = "";
  bool showTermsError = false;

  final loginController = LoginController();

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+84";
    super.initState();
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('assets/images/background.jpg'),
          //         fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
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
                      Image.asset(
                        'assets/images/img1.jpg',
                        width: 300,
                        height: 170,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Login or Register",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "If you don't have an account, you will be navigated to the registration page.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: countryController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Text(
                              "|",
                              style:
                                  TextStyle(fontSize: 33, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextField(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                phone = value;
                                LoginPage.phoneNum = value;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone",
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                            Text(
                              'You are Doctor',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 157, 156, 156)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        alignment: Alignment.center,
                        child: Text(
                          showTermsError
                              ? 'Please enter a valid Phone Number '
                              : '', // Nếu _isChecked là true, hiển thị chuỗi trống
                          style: TextStyle(
                            color: Color.fromARGB(255, 214, 47, 35),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue.shade600,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if (int.tryParse(phone) == null ||
                                  phone.length < 8 ||
                                  phone.length > 11) {
                                setState(() {
                                  showTermsError = true;
                                });
                              } else {
                                setState(() {
                                  showTermsError = false;
                                });
                                var sendPhone = int.parse(phone).toString();

                                if (_isChecked) {
                                  var check = await loginController.loginDoctor(
                                      sendPhone, context);

                                  if (check != -1) {
                                    await FirebaseAuth.instance
                                        .verifyPhoneNumber(
                                      phoneNumber:
                                          '${countryController.text + sendPhone}',
                                      verificationCompleted:
                                          (PhoneAuthCredential credential) {},
                                      verificationFailed:
                                          (FirebaseAuthException e) {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          text: 'Can not send OTP',
                                        );
                                      },
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        LoginPage.verify = verificationId;
                                        LoginPage.approle = "Doctor";
                                        LoginPage.userid = check.toString();
                                        Navigator.pushNamed(context, 'verify');
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {},
                                    );
                                  } else {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new DoctorRegisterPage()));
                                  }
                                } else {
                                  var check = await loginController.loginPatient(
                                      sendPhone, context);

                                  if (check != -1) {
                                     FirebaseAuth.instance
                                        .verifyPhoneNumber(
                                      phoneNumber:
                                          '${countryController.text + sendPhone}',
                                      verificationCompleted:
                                          (PhoneAuthCredential credential) {},
                                      verificationFailed:
                                          (FirebaseAuthException e) {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.error,
                                          text: 'Can not send OTP',
                                        );
                                      },
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        LoginPage.verify = verificationId;
                                        LoginPage.approle = "Patient";
                                        LoginPage.userid = check.toString();
                                        Navigator.pushNamed(context, 'verify');

                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           MyVerify()),
                                        // );
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {},
                                    );
                                  } else {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new PatientRegisterPage()));
                                  }
                                }
                              }
                            },
                            child: Text("Send the code")),
                      )
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

  void onRegister() {
    // Do something
  }
}
