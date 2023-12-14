import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {
  @override
  State<DoctorProfile> createState() {
    // TODO: implement createState
    return _DoctorProfile();
  }
}

class _DoctorProfile extends State<DoctorProfile> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  //var user = UserData.myUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 330,
              child: const Text(
                "What's Your Name?",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        // else if (!isAlpha(value)) {
                        //   return 'Only Letters Please';
                        // }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'First Name'),
                      //controller: firstNameController,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: TextFormField(
                      // Handles Form Validation for Last Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        // else if (!value) {
                        //   return 'Only Letters Please';
                        // }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      //controller: secondNameController,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
