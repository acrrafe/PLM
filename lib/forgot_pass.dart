import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plm_enhancement_application/firebase_services/firebase_auth_methods.dart';
import 'package:plm_enhancement_application/utils/showSnackbar.dart';

import 'main.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key, required this.title});
  final String title;

  @override
  State<ForgotPassPage> createState() => ForgotPassPageState();
}

class ForgotPassPageState extends State<ForgotPassPage> {
  TextEditingController _emailController = TextEditingController();
  final FocusNode _focusNodeE = FocusNode();
  bool _isFocusedE = false;

  @override
  void initState() {
    super.initState();
    _focusNodeE.addListener(() {
      setState(() {
        _isFocusedE = _focusNodeE.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    if (!_emailController.text.contains("@plm.edu.ph")) {
      showSnackBar(context, "Please use your PLM Email");
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    "Email for Reset Password is sent!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5A106),
                    ),
                    child: const Text(
                      'Go to Home',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } on FirebaseException catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    e.message ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5A106),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    }
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
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          'FORGOT PASSWORD',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Image.asset(
                'images/plm_logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 2),
              const Text(
                'Forgot',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Enter your PLM Email', style: TextStyle(fontWeight: FontWeight.w500),),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailController,
                              focusNode: _focusNodeE,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: _isFocusedE
                                      ? Color(0xFF343BA6)
                                      : Colors.grey,
                                ),
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
                            Center(
                              child: Text('Click the button to send link in your email.', style: TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 14),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  passwordReset();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xFF343BA6),
                                ),
                                child: SizedBox(
                                  width: 150,
                                  height: 52,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.send),
                                      SizedBox(width: 8),
                                      Text(
                                        'Send Link',
                                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 1.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
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
