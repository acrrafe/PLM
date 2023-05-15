import 'package:flutter/material.dart';

import 'home_guest.dart';
import 'home_student.dart';

void main() {
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
                      TextField(keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
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
                      TextField(obscureText: true,
                        decoration: InputDecoration(
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
                        InkWell(onTap: () => _showForgotPasswordDialog(context), // Show alert dialog
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoardStudentPage(title: "Dashboard",)));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoardGuestPage(title: "Dashboard",)));
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

