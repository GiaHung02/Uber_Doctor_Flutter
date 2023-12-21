// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber_doctor_flutter/constants.dart';
import 'package:uber_doctor_flutter/login_service.dart';
import 'package:uber_doctor_flutter/main.dart';
import 'package:uber_doctor_flutter/src/call/util.dart';
import 'package:uber_doctor_flutter/src/widgets/custom_appbar.dart';

// Project imports:
// import '../../constants.dart';
// import '../../login_service.dart';
// import 'util.dart';

class LoginPageDoctor extends StatefulWidget {
  const LoginPageDoctor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPageDoctor> {
  final _userIDTextCtrl = TextEditingController(text: 'user_id');
  final _passwordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    getUniqueUserId().then((userID) async {
      setState(() {
        _userIDTextCtrl.text = userID;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            
          
            children: [
             Positioned(
                top: 20,
                right: 10,
                child: BackToButton(),
              ),
              logo(),
              const SizedBox(height: 50),
              userIDEditor(),
              // passwordEditor(),
              const SizedBox(height: 30),
              signInButton(),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget BackToButton() {
    return Ink(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
      ),
      child: IconButton(
        icon: const Icon(Icons.backspace),
        iconSize: 20,
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamed(
            context,
            PageRouteNames.home2,
          );
        },
      ),
    );
  }

  Widget logo() {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: '',
          style: TextStyle(color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text: 'DOC',
              style: TextStyle(color: Colors.blue),
            ),
            TextSpan(text: 'TOR'),
          ],
        ),
      ),
    );
  }

  Widget userIDEditor() {
    return TextFormField(
      controller: _userIDTextCtrl,
      decoration: const InputDecoration(
        labelText: 'Phone Num.(User for user id)',
      ),
    );
  }

  // Widget passwordEditor() {
  //   return ValueListenableBuilder<bool>(
  //     valueListenable: _passwordVisible,
  //     builder: (context, isPasswordVisible, _) {
  //       return TextFormField(
  //         obscureText: !isPasswordVisible,
  //         decoration: InputDecoration(
  //           labelText: 'Password.(Any character for test)',
  //           suffixIcon: IconButton(
  //             icon: Icon(
  //               isPasswordVisible ? Icons.visibility : Icons.visibility_off,
  //             ),
  //             onPressed: () {
  //               _passwordVisible.value = !_passwordVisible.value;
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget signInButton() {
    return ElevatedButton(
      onPressed: _userIDTextCtrl.text.isEmpty
          ? null
          : () async {
              login(
                userID: _userIDTextCtrl.text,
                userName: 'user_${_userIDTextCtrl.text}',
              ).then((value) {
                onUserLogin();

                Navigator.pushNamed(
                  context,
                  PageRouteNames.doctorCall,
                );
              });
            },
      child: const Text('Submit', style: textStyle),
    );
  }
}
