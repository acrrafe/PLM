import 'package:flutter/material.dart';
import 'package:plm_enhancement_application/notification.dart';
import 'package:plm_enhancement_application/student_profile.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'change_password.dart';
import 'main.dart';
import 'plm_courses_page.dart';

class DashBoardStudentPage extends StatefulWidget {
  const DashBoardStudentPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DashBoardStudentWidgetState createState() => _DashBoardStudentWidgetState();
}
// Drawer Class
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Drawer Content
    return WillPopScope(
        onWillPop: () async => false,
    child: Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Robert Motabato'),
            accountEmail: Text('robert.motabato69@example.com'),
            currentAccountPicture: CircleAvatar( backgroundColor: Colors.grey,
              backgroundImage: AssetImage('images/ic_alden.jpg'),
            ),
            decoration: BoxDecoration(color: Color(0xFF343BA6)),
          ),
          const SizedBox(height: 0),
          ListTile(leading: const Icon(Icons.person, color: Colors.black), title: const Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfilePage()));
            },
          ),
          ListTile(leading: const Icon(Icons.lock, color: Colors.black), title: const Text('Change Password'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
            },
          ),
          Expanded(child: Container()),
          ListTile(leading: const Icon(Icons.logout, color: Colors.black), title: Row(
              children: const [
                SizedBox(width: 0), // adjust the spacing here
                Text('Logout'),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
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
final borderRadius = BorderRadius.circular(24);
class _DashBoardStudentWidgetState extends State<DashBoardStudentPage> {
  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationPage()));
              },
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: Image.asset('images/home_plm_img.png', fit: BoxFit.cover, width: double.infinity),
              ),
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
                      _launchLocatePLM(); // Launch Google Maps PLM
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
                    onTap: () {
                       _lunchHD();
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
  // HD Form
  _lunchHD() {
    const url = 'https://web4.plm.edu.ph/StudentHealthDeclaration/';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
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
    const url = 'https://plm.edu.ph/crs/';
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
}