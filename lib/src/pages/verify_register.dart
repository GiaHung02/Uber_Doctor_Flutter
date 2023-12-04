import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uber_doctor_flutter/src/controllers/auth/signup_controller.dart';
import 'package:uber_doctor_flutter/src/model/register_doctor_model.dart';
import 'package:uber_doctor_flutter/src/model/register_patient_model.dart';
import 'package:uber_doctor_flutter/src/pages/doctor_register_page.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';
import 'package:uber_doctor_flutter/src/pages/login_page.dart';
import 'package:uber_doctor_flutter/src/pages/patient_register_page.dart';

class MyVerifyRegister extends StatefulWidget {
  const MyVerifyRegister({Key? key}) : super(key: key);

  @override
  State<MyVerifyRegister> createState() => _MyVerifyRegisterState();
}

class _MyVerifyRegisterState extends State<MyVerifyRegister> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final SignUpController signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    // Nhận tham số dataRegister
    final Map<String, dynamic> dataRegister =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";

    RegisterPatientModel patientModel =
        RegisterPatientModel.fromJson(dataRegister);

    RegisterDoctorModel doctorModel =
        RegisterDoctorModel.fromJson(dataRegister);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img1.jpg',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                onChanged: (value) => {code = value},
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        String myVerificationId = PatientRegisterPage.verify ??
                            DoctorRegisterPage.verify;

                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: myVerificationId,
                                smsCode: code);

                        // Sign the user in (or link) with the credential
                        UserCredential userCredential =
                            await auth.signInWithCredential(credential);

                        // Lấy ra token từ UserCredential
                        String? token = await userCredential.user?.getIdToken();

                        print('token $token');

                        // Kiểm tra xem token có giá trị hay không
                        if (token != null) {
                          if (PatientRegisterPage.verify != null) {
                            var status =
                                signUpController.createPatient(patientModel);

                            if (await status == 201) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: "Registered successfully",
                                onConfirmBtnTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "home", (route) => false);
                                },
                                confirmBtnText: 'Back to login',
                              );
                            } else if (await status == 123) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text:
                                    'Switch to a different IP or a different WiFi',
                              );
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: "Registration failed",
                              );
                            }
                          } else {
                            var status =
                                signUpController.createDoctor(doctorModel);

                            if (await status == 201) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: "Registered successfully",
                                onConfirmBtnTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "home", (route) => false);
                                },
                                confirmBtnText: 'Back to login',
                              );
                            } else if (await status == 123) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text:
                                    'Switch to a different IP or a different WiFi',
                              );
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                text: "Registration failed",
                              );
                            }
                          }
                        } else {
                          print('Failed to get Firebase Auth Token.');
                        }
                      } catch (e) {
                        print("Have error");
                      }
                    },
                    child: Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
