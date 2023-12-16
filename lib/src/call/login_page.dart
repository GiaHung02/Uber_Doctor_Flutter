// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber_doctor_flutter/main.dart';
import 'package:uber_doctor_flutter/src/widgets/custom_appbar.dart';

// Project imports:
import '../../constants.dart';
import '../../login_service.dart';
import 'util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _userIDTextCtrl = TextEditingController(text: '123456');
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
      appBar: AppBar(title: Text("h")),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.exit_to_app_sharp),
                iconSize: 20,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage("s", title: "title"),
                    ),
                  );
                },
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

  Widget logo() {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: 'UBER',
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
                  PageRouteNames.home,
                );
              });
            },
      child: const Text('Sign In', style: textStyle),
    );
  }
}
