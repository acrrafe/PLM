import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plm_enhancement_application/create_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_services/firebase_auth_methods.dart';
import 'forgot_pass.dart';
import 'home_guest.dart';
import 'home_student.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,),
      home: const MyAppHomePage(title: 'Flutter Login Pagge'),
    );

  }
}

class MyAppHomePage extends StatefulWidget {
  const MyAppHomePage({super.key, required this.title});
  final String title;

  @override // Show login
  State<MyAppHomePage> createState() => MyAppHomePageState();
}


class MyAppHomePageState extends State<MyAppHomePage> {
  bool _backButtonPressedOnce = false;
  final FocusNode _focusNodeE = FocusNode();
  bool _isFocusedE = false;
  final FocusNode _focusNodePS = FocusNode();
  bool _isFocusedPS = false;

  @override
  void initState() {
    super.initState();
    checkUserAuthentication();
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

  void handleUserAuthentication(User? user) async {
    if (user != null) {
      final String? text = user.email;
      print("EMAIL: $text");

      if (user.emailVerified) {
      // Check the sharedPreference if the flag is true
      if (text != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool? flag = prefs.getBool(text);
        print("FLAG: $flag");
        if (flag == true) {

            }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: text)));
        }
        }
      }
      // User is signed in, handle the logged-in state
      // For example, navigate to the main screen or display user-specific content
    } else {
      // No user is signed in, handle the logged-out state
      // For example, show the login/register screen
    }
  }

  void checkUserAuthentication() {
    FirebaseAuthMethods(FirebaseAuth.instance).checkUserAuthentication(handleUserAuthentication);
  }

  void loginUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Double Back pressed is need to close the application
        if (_backButtonPressedOnce) {
          return true;
        } else {
          setState(() {
            _backButtonPressedOnce = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 3),
          ));
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon and Header Message
                const SizedBox(height: 16),
                Image.asset('images/plm_logo.png'),
                const SizedBox(height: 16),
                const Text('Welcome',
                  style: TextStyle(fontSize: 34, letterSpacing: 1.0, fontWeight: FontWeight.w600)),
                const Text('Haribon!',
                  style: TextStyle(fontSize: 34, letterSpacing: 1.0, fontWeight: FontWeight.w600)),
                const SizedBox(height: 32), // MarginTop

            Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text Field Email
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
                      const SizedBox(height: 16),
                      // Text Field Password
                      const Text('Password'),
                      const SizedBox(height: 8),
                      TextField(controller: _passwordController,
                        obscureText: true,
                        focusNode: _focusNodePS,
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
                      const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassPage(title: "ForgotPage"))), // Show alert dialog
                          child: const Padding(padding: EdgeInsets.all(8.0),
                            child: Text('Forgot Password?',
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14)
                            ),
                          ),
                        ),
                      ],
                    ),
                      const SizedBox(height: 15.0),
                      ElevatedButton(
                        onPressed: () {
                          _backButtonPressedOnce = false;
                          loginUser();
                          _emailController.clear();
                          _passwordController.clear();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoardStudentPage(title: "Dashboard",)));
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
                              Text('Login',
                                style: TextStyle(fontSize: 22)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          _backButtonPressedOnce = false;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoardGuestPage(title: "Dashboard",)));
                          _emailController.clear();
                          _passwordController.clear();
                          },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                          backgroundColor: const Color(0xFFDDB438),
                        ),
                        child: SizedBox(width: double.infinity, height: 52,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Guest',
                                style: TextStyle(fontSize: 22)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                          InkWell(onTap: () {
                            _backButtonPressedOnce = false;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountPage(title: "Create Account",))); // Show alert dialog
                          },
                            child: const Padding(padding: EdgeInsets.all(3.0),
                              child: Text('Sign up',
                                  style: TextStyle(color: Color(0xFF343BA6), fontWeight: FontWeight.bold, fontSize: 12)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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

