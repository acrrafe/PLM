import 'package:flutter/material.dart';
import 'login_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}
class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
        centerTitle: true,
        title: const Text('CHANGE PASSWORD', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,)),
      ),
      body: Container(color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Image.asset('images/plm_logo.png', width: 120, height: 120),
              ),
              const SizedBox(height: 16),
              const Text('Change', style: TextStyle(fontSize: 34, letterSpacing: 1.0, fontWeight: FontWeight.w600)),
              const Text('Password', style: TextStyle(fontSize: 34, letterSpacing: 1.0, fontWeight: FontWeight.w600)),
              const SizedBox(height: 32),
            ],
          ),
              const Text('PLM Email', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(keyboardType: TextInputType.emailAddress, obscureText: true,
                decoration: InputDecoration(hintText: 'Current Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFF343BA6), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFF343BA6), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('New Password', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(obscureText: true,
                decoration: InputDecoration( hintText: 'Enter your new password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFF343BA6), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFF343BA6), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Confirm Password', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm your new password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFF343BA6), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFF343BA6), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 48),
                            const SizedBox(height: 16),
                            const Text('You have successfully changed your password!', textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
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
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), backgroundColor: const Color(0xFF343BA6),
                ),
                child: SizedBox(width: double.infinity, height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Change Password', style: TextStyle(fontSize: 22)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}