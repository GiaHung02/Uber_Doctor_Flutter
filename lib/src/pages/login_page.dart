import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.cover)),
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
                        'Login',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Text(
                      //   'or with name and password',
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     color: Color.fromARGB(255, 200, 67, 10),
                      //   ),
                      // ),
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
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'User Name...',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please enter your User Name';
                            }

                            return null;
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
                            hintText: 'nguyen@gmail.com',
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
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Password (length > 8 )',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (value.length > 8) {
                                return null;
                              } else {
                                return 'Please enter password with length >8';
                              }
                            } else {
                              return 'Please enter password';
                            }
                          },
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),

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
                            Text(
                              'I Agree with the terms and conditions',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 157, 156, 156)),
                            ),
                          ],
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      print('form submiitted');
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 242, 218, 221)),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 239, 9, 224),
                                        fontSize: 18),
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

  void onRegister() {
    // Do something
  }
}
