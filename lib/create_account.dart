import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plm_enhancement_application/firebase_services/firebase_auth_methods.dart';
import 'package:plm_enhancement_application/utils/showSnackbar.dart';

import 'main.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key, required this.title});
  final String title;

  @override // Show login
  State<CreateAccountPage> createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final FocusNode _focusNodeE = FocusNode();
  bool _isFocusedE = false;
  final FocusNode _focusNodePS = FocusNode();
  bool _isFocusedPS = false;

  @override
  void initState() {
    super.initState();
    _focusNodeE.addListener(() {
      setState(() {
        _isFocusedE = _focusNodeE.hasFocus;
        _isFocusedPS = _focusNodePS.hasFocus;
      });
    });
  }
  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _focusNodeE.dispose();
  //   _focusNodePS.dispose();
  //   super.dispose();
  // }

  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF343BA6),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ),
          title: const Text('SIGN UP',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25,),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text Field Email
                          const SizedBox(height: 14),
                          const Text('PLM Email'),
                          const SizedBox(height: 8),
                          TextField(controller: _emailController,
                            focusNode: _focusNodeE,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon:  Icon(Icons.email,
                                  color: _isFocusedE ? Color(0xFF343BA6) : Colors.grey ),
                              hintText: 'Enter your email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF343BA6),
                                  width: 2.0,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF343BA6),
                                  width: 2.0,
                                ),
                              ),
                            ),

                          ),
                          const SizedBox(height: 14),
                          // Text Field Password
                          const Text('Password'),
                          const SizedBox(height: 8),
                          TextField(controller: _passwordController,
                            focusNode: _focusNodePS,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon:  Icon(Icons.lock,
                                  color: _isFocusedPS ? Color(0xFF343BA6) : Colors.grey ),
                              hintText: 'Enter your password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF343BA6),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF343BA6),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          ElevatedButton(
                            onPressed: () {
                              if(!_emailController.text.contains("@plm.edu.ph")){
                                showSnackBar(context, "Please use your PLM Email");
                              }else if(_passwordController.text.length < 6){
                                showSnackBar(context, "Please make your password at least 6 characters");
                              } else{
                                signUpUser();
                                showDialog(context: context, builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.check_circle, color: Colors.green, size: 48),
                                        const SizedBox(height: 16),
                                        const Text('Email Verification is sent! \nVerify your email first to login', textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16)),
                                        const SizedBox(height: 24),
                                        ElevatedButton(
                                          onPressed: () {
                                            _emailController.clear();
                                            _passwordController.clear();
                                            Navigator.popUntil(context, (route) => route.isFirst);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFFD5A106),
                                          ),
                                          child: const Text('Go to Home',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), backgroundColor: const Color(0xFF343BA6), // change the background color
                              // other properties, such as text color, can also be customized
                            ),
                            child: SizedBox(width: double.infinity, height: 52,
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Sign Up',
                                      style: TextStyle(fontSize: 22)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
// Forgot Password Alert Dialog
void _showForgotPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Forgot Password?'),
      content: const Text('Please contact customer support to reset your password.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

