import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plm_enhancement_application/one_setup_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_student.dart';
import '../http_request_method/http_request.dart';
import '../main.dart';
import '../utils/showSnackbar.dart';

class UserState extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);

      // Save email as shared preference ID
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(email, true);
      print("Sign Up Email: $email");
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(context, e.message!); // Displaying the usual firebase error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        await sendEmailVerification(context);
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 48),
                const SizedBox(height: 16),
                const Text(
                    'Email Verification is sent! \nVerify your email first to login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
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
      }else {
        // Check the sharedPreference if the flag is true
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool? flag = prefs.getBool(email);
        print("FIREBASE FLAG $flag");

        RemoteService remoteService = RemoteService();
        bool userExists = await remoteService.checkUserExists(email);
        if(userExists){
          // Direct to Dashboard
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(email, false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: email)));
        }else{
          // First Time user
          if (flag == true) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SetupProfilePage(text: email)));
          } else {
            // Direct to Dashboard
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: email)));
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }


  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context, String email) async {
    try {
      await _auth.signOut();
      Provider.of<UserState>(context, listen: false).setUser(null);

      // Remove shared preference ID
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Sign out Email: $email");
      prefs.remove(email);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  void checkUserAuthentication(void Function(User?) onUserChanged) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      onUserChanged(user);
    });
  }
}
