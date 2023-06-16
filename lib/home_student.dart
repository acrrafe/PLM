import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plm_enhancement_application/firebase_services/firebase_auth_methods.dart';
import 'package:plm_enhancement_application/hd_failed.dart';
import 'package:plm_enhancement_application/hd_success.dart';
import 'package:plm_enhancement_application/plm_map.dart';
import 'package:plm_enhancement_application/student_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'change_password.dart';
import 'hd_form.dart';
import 'hd_form_close.dart';
import 'http_request_method/http_request.dart';
import 'main.dart';
import 'plm_courses_page.dart';


class MyDashboard extends StatelessWidget {
  final String text;
  const MyDashboard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>(
      create: (_) => UserState(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DashBoardStudentPage(text: text),
      ),
    );
  }
}

class DashBoardStudentPage extends StatefulWidget {
  final String? text;

  const DashBoardStudentPage({Key? key, required this.text}) : super(key: key);

  @override
  _DashBoardStudentWidgetState createState() => _DashBoardStudentWidgetState();
}
// Drawer Class
class MyDrawer extends StatefulWidget {
  final String? text;
  const MyDrawer({Key? key, this.text}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Map<String, dynamic> studentData = {}; // Store the fetched data

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    fetchData();
  }

  void fetchData() async {
    if (widget.text != null) {
      RemoteService remoteService = RemoteService();
      Map<String, dynamic> data = await remoteService.fetchData(widget.text!);
      print(data);
      setState(() {
        studentData = data;
        print(studentData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String studentFName = studentData['firstName'] ?? 'No Name';
    String studentLName = studentData['lastName'] ?? 'No Name';
    String studentName = '$studentFName $studentLName' ;
    // Drawer Content
    return WillPopScope(
      onWillPop: () async => false,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserAccountsDrawerHeader(
              accountName:  Text(studentName),
              accountEmail: Text(widget.text ?? 'Email is Invalid'),
              // currentAccountPicture: CircleAvatar(
              //   backgroundColor: Colors.grey,
              //   backgroundImage: AssetImage('images/user_profile.jpg'),
              // ),
              decoration: const BoxDecoration(color: Color(0xFF343BA6)),
            ),
            const SizedBox(height: 0),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentProfilePage(text: widget.text)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.black),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage(text: widget.text)),
                );
              },
            ),
            Expanded(child: Container()),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: Row(
                children: const [
                  SizedBox(width: 0), // adjust the spacing here
                  Text('Logout'),
                ],
              ),
              onTap: () {
                FirebaseAuthMethods(FirebaseAuth.instance).signOut(context, widget.text ?? "No Email");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
// WebView Class
class WebViewLauncher extends StatefulWidget {
  final String url;
  const WebViewLauncher({required this.url});
  @override
  _WebViewLauncherState createState() => _WebViewLauncherState();
}

class _WebViewLauncherState extends State<WebViewLauncher> {
  bool _isLoading = true;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
        backgroundColor: const Color(0xFF343BA6),
        actions: const <Widget>[
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebView(initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
            },
            onPageFinished: (finish) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) {
              print('Webview error: ${error.description}');
            },
          ),
          _isLoading ? const Center(
            child: CircularProgressIndicator(),
          )
              : Container(),
        ],
      ),
    );
  }
}
class CarouselWithArrows extends StatefulWidget {
  @override
  _CarouselWithArrowsState createState() => _CarouselWithArrowsState();
}

class _CarouselWithArrowsState extends State<CarouselWithArrows> {
  CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: [
            _buildCarouselItem('images/plm_news1.jpg', 0),
            _buildCarouselItem('images/plm_news2.jpg', 1),
            _buildCarouselItem('images/plm_news3.jpg', 2),
            // Add more carousel items here
          ],
          options: CarouselOptions(
            height: 250,
            enableInfiniteScroll: true,
            initialPage: 0,
            viewportFraction: 1.0,
            aspectRatio: 16 / 9,
            autoPlay: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(String imagePath, int index) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _carouselController.previousPage();
                  setState(() {
                    _currentIndex--;
                  });
                },
              ),
            ),
            Visibility(
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  _carouselController.nextPage();
                  setState(() {
                    _currentIndex++;
                  });
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildDotIndicators(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDotIndicators() {
    return List<Widget>.generate(3, (index) {
      return Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.blue[100] : Colors.grey,
        ),
      );
    });
  }
}

final borderRadius = BorderRadius.circular(24);
class _DashBoardStudentWidgetState extends State<DashBoardStudentPage> {
  Map<String, dynamic> studentData = {}; // Store the fetched data

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    fetchData();
  }

  void fetchData() async {
    if (widget.text != null) {
      RemoteService remoteService = RemoteService();
      Map<String, dynamic> data = await remoteService.fetchData(widget.text!);
      print(data);
      setState(() {
        studentData = data;
        print(studentData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String studentFName = studentData['firstName'] ?? 'No Name';
    String studentLName = studentData['lastName'] ?? 'No Name';
    String studentName = '$studentFName $studentLName' ;
    int studNum = studentData['studentNum'] ?? 0;
    return WillPopScope(
        onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF343BA6),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          centerTitle: true,
          title: const Text('HOME',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,
            ),
          ),
        ),
        drawer:  MyDrawer(text: widget.text),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselWithArrows(),
              // Card view About PLM
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
              child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                child: InkWell(
                  onTap: () {
                    _launchAboutPLM(); // Launch PLM Website
                  },
                  borderRadius: borderRadius,
                  splashColor: Colors.grey.withOpacity(0.5),
                  child: Padding(padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About PLM',
                                style: Theme.of(context).textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 3),
                              Text('Learn about the admission',
                                style: Theme.of(context).textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 14)),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.school),
                                  const SizedBox(width: 8),
                                  Text('Courses',
                                    style: Theme.of(context).textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.phone),
                                  const SizedBox(width: 8),
                                  Text('Contact Info.',
                                    style: Theme.of(context).textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(alignment: Alignment.topRight,
                            child: Container(padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(color: const Color(0xFF343BA6),
                                borderRadius: BorderRadius.circular(8)),
                              child: Image.asset('images/about_plm.png', height: 70, width: 70),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ),
              // Card view Locate PLM
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MapGuidePage())); // Show alert dialog
                      // _launchLocatePLM(); // Launch Google Maps PLM
                    },
                    borderRadius: borderRadius,
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Locate PLM',
                                  style: Theme.of(context).textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text('Explore Pamantasan',
                                  style: Theme.of(context).textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(width: 8),
                                    Text('Location',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.picture_in_picture),
                                    const SizedBox(width: 8),
                                    Text('Vicinity',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(alignment: Alignment.topRight,
                              child: Container(padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(color: const Color(0xFF343BA6),
                                  borderRadius: BorderRadius.circular(8)),
                                child: Image.asset('images/plm_map.png', height: 70, width: 70,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card view Academic Calendar
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius),
                  child: InkWell(
                    onTap: () {
                      _launchCalendar();
                    },
                    borderRadius: borderRadius,
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Academic Calendar',
                                  style: Theme.of(context).textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text('View Pamantasan Schedule',
                                  style: Theme.of(context).textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 13)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.timeline),
                                    const SizedBox(width: 8),
                                    Text('Timeline',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.save),
                                    const SizedBox(width: 8),
                                    Text('Save Calendar',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(alignment: Alignment.topRight,
                              child: Container(padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(color: const Color(0xFF343BA6),
                                  borderRadius: BorderRadius.circular(8)),
                                child: Image.asset('images/plm_sched.png', height: 70, width: 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card view Library Form
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius,),
                  child: InkWell(
                    onTap: () {
                      _lunchLibrary();
                    },
                    borderRadius: borderRadius,
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Library Registration Form',
                                  style: Theme.of(context).textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text('Make an appointment',
                                  style: Theme.of(context).textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.library_books),
                                    const SizedBox(width: 8),
                                    Text('Read',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.warning_amber_sharp),
                                    const SizedBox(width: 8),
                                    Text('Important',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(alignment: Alignment.topRight,
                              child: Container(padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF343BA6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset('images/plm_library.png', height: 70, width: 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card view SFE
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius,),
                  child: InkWell(
                    onTap: () {
                      _launchSFE();
                    },
                    borderRadius: borderRadius,
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Student Faculty  Evaluation',
                                  style: Theme.of(context).textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text('Evaluate your professors',
                                  style: Theme.of(context).textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.grade),
                                    const SizedBox(width: 8),
                                    Text('Remarks',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.feedback),
                                    const SizedBox(width: 8),
                                    Text('Concerns',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(alignment: Alignment.topRight,
                              child: Container(padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(color: const Color(0xFF343BA6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset('images/plm_sfe.png', height: 70, width: 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card view HD Form
                Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                  child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius,),
                    child: InkWell(
                      onTap: () async {
                        try{
                          final currentTime = DateTime.now();
                          final startOfDay = DateTime(currentTime.year, currentTime.month, currentTime.day, 4, 0);
                          final endOfDay = DateTime(currentTime.year, currentTime.month, currentTime.day, 20, 0);
                          String? email = widget.text;
                          String keySucFail = '${email}_hdResult';
                          String formattedDateKey = '${email}_hdDate';
                          String? formattedDateValue = await getStoredValue(formattedDateKey);
                          print("FORMATED DATE VALUE: $formattedDateValue") ;
                          String? valueSucFail = await getStoredValue(keySucFail);
                          print("SUCCESS KEY VALUE: $valueSucFail");
// ...
                          if (currentTime.isAfter(startOfDay) && currentTime.isBefore(endOfDay)) {
                            if (formattedDateValue == null && valueSucFail == null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HealthDeclarationFormPage(
                                    email: widget.text ?? "No Email",
                                    name: studentName,
                                    studNum: studNum,
                                  ),
                                ),
                              );
                            } else {
                              // Convert formattedDate to a DateTime object
                              String formattedDate = formattedDateValue!.replaceAll('/', '-');
                              DateTime parsedDate = DateFormat('yyyy-dd-MM').parse(formattedDate);
                              print("PARSE DATE: $parsedDate");
                              print("CURRENT TIME: $currentTime");
                              // IF THE FORM IS OPEN CHECK IF USER HD FORM IS STILL VALID TO THE CURRENT DATE
                              // IF IT IS YESTERDAY THEN GO TO THE HD FORM
                              if ((parsedDate.year == currentTime.year &&
                                  parsedDate.month == currentTime.month &&
                                  parsedDate.day == currentTime.day) || parsedDate.isBefore(currentTime)){
                                // IF THE FORM IS OPEN CHECK IF USER HD FORM IS STILL VALID TO THE CURRENT DATE
                                // IF IT IS STILL VALID THEN CHECK IF THEIR HD IS SUCCESS OR FAILED
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HealthDeclarationFormPage(
                                      email: widget.text ?? "No Email",
                                      name: studentName,
                                      studNum: studNum,
                                    ),
                                  ),
                                );
                              }
                              else {
                                // IF SUCCESS SHOW THE HD FORM THAT ALLOWS TO GO TO SCHOOL
                                if (valueSucFail != null && valueSucFail == 'success') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HDSuccessPage(
                                        email: widget.text!,
                                        name: studentName,
                                        studNum: studNum,
                                      ),
                                    ),
                                  );
                                  // IF FAILED SHOW THE HD FORM THAT DIDN'T ALLOWS TO GO TO SCHOOL
                                } else if (valueSucFail != null && valueSucFail == 'failed') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HDFailedPage(
                                        email: widget.text!,
                                        name: studentName,
                                        studNum: studNum,
                                      ),
                                    ),
                                  );
                                }
                              }
                              // IF THE TIME IS NOT BETWEEN 4AM AND 3PM, THEN THE USER WILL DIRECT TO THE CLOSE HD FORM
                            }
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HealthDeclarationFormClosePage(
                                  title: '',
                                ),
                              ),
                            );
                          }
                        }catch(e){
                          print(e);
                        }
                      },
                      borderRadius: borderRadius,
                      splashColor: Colors.grey.withOpacity(0.5),
                      child: Padding(padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('HD Form',
                                    style: Theme.of(context).textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 3),
                                  Text('Answer HD Form',
                                    style: Theme.of(context).textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 14)),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.health_and_safety),
                                      const SizedBox(width: 8),
                                      Text('Health Concern',
                                        style: Theme.of(context).textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(Icons.warning_amber_sharp),
                                      const SizedBox(width: 8),
                                      Text('Important',
                                        style: Theme.of(context).textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF343BA6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'images/plm_hd.png',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              // Card view Announcements
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  child: InkWell(
                    onTap: () {
                      _lunchAnnouncements();
                    },
                    borderRadius: borderRadius,
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Announcements',
                                  style: Theme.of(context).textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text('View Announcements and Events in Pamantasan',
                                  style: Theme.of(context).textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.announcement),
                                    const SizedBox(width: 8),
                                    Text('Stay Updated',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.phone),
                                    const SizedBox(width: 8),
                                    Text('Contact Info.',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF343BA6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset('images/plm_announ.png', height: 70, width: 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card view CRS
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Card(color: const Color(0xFFFAF9F6), elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius),
                  child: InkWell(
                    onTap: () {
                      _launchCRS();
                    },
                    borderRadius: borderRadius,
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Computerized Registration System (CRS)',
                                  style: Theme.of(context).textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.grade),
                                    const SizedBox(width: 8),
                                    Text('View your grades',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.file_copy_sharp),
                                    const SizedBox(width: 8),
                                    Text('Detailed Information',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(alignment: Alignment.topRight,
                              child: Container(padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF343BA6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset('images/ic_crs.png', height: 70, width: 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card view Courses in PLM
              Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                child: Card(color: Color(0xFFFAF9F6), elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius,),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CollegeCoursesPage()));
                    },
                    borderRadius: borderRadius,
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Padding(padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Courses in PLM',
                                  style: Theme.of(context).textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 3),
                                Text('View Colleges Courses',
                                  style: Theme.of(context).textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 14)),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.library_books),
                                    const SizedBox(width: 8),
                                    Text('View your interest',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.event),
                                    const SizedBox(width: 8),
                                    Text('Stay updated',
                                      style: Theme.of(context).textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF343BA6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset('images/plm_org.png', height: 70, width: 70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  // Library Form
  _lunchLibrary() {
    const url = 'https://forms.office.com/pages/responsepage.aspx?id=p1U_yOh_NEm3WQmSZDCu8IMDH7ctTvdGl_NhPAgGJDlUNUcxOVIwMEZHWjBRQkNXUVZVQVVKNFBITi4u&fswReload=1&fswNavStart=1683747692724';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  // CRS
  _launchCRS()  {
    const url = 'https://web1.plm.edu.ph/crs/';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  // SFE
  _launchSFE()  {
    const url = 'https://web2.plm.edu.ph/sfe/';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  // Calendar
  _launchCalendar()  {
    const url = 'https://plm.edu.ph/academics/academic-calendar';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  // About PLM
  _launchAboutPLM()  {
    const url = 'https://plm.edu.ph/about';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  // Locate PLM
  _launchLocatePLM()  {
    const url = 'https://www.google.com.ph/maps/place/Plm/@14.5866826,120.9765389,19.08z/data=!4m6!3m5!1s0x3397ca3ccae52fb5:0xe17951ed729cd353!8m2!3d14.5868339!4d120.9764421!16s%2Fg%2F11c1rtp04d';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  // Announcements
  _lunchAnnouncements() {
    const url = 'https://plm.edu.ph/news/announcements';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }

  Future<String?> getStoredValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}