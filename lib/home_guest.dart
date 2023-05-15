import 'package:flutter/material.dart';
import 'package:plm_enhancement_application/notification.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';
import 'plm_courses_page.dart';

class DashBoardGuestPage extends StatefulWidget {
  const DashBoardGuestPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  DashBoardGuestWidgetState createState() => DashBoardGuestWidgetState();
}
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Name: Guest'),
              accountEmail: Text('Email: Guest'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person,
                color: Colors.black,),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF343BA6),
              ),
            ),
            const SizedBox(height: 0),
            Expanded(child: Container()),
            ListTile(
              leading: const Icon(Icons.login, color: Colors.black),
              title: Row(
                children: const [
                  SizedBox(width: 0), // adjust the spacing here
                  Text('Login'),
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
        actions: const <Widget>[
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
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
class DashBoardGuestWidgetState extends State<DashBoardGuestPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(backgroundColor: const Color(0xFF343BA6),
          leading: Builder(builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          centerTitle: true,
          title: const Text('HOME',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: Image.asset('images/home_plm_img.png', fit: BoxFit.cover, width: double.infinity)),
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
  _launchCalendar()  {
    const url = 'https://plm.edu.ph/academics/academic-calendar';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  _launchAboutPLM()  {
    const url = 'https://plm.edu.ph/about';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
  _launchLocatePLM()  {
    const url = 'https://www.google.com.ph/maps/place/Plm/@14.5866826,120.9765389,19.08z/data=!4m6!3m5!1s0x3397ca3ccae52fb5:0xe17951ed729cd353!8m2!3d14.5868339!4d120.9764421!16s%2Fg%2F11c1rtp04d';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
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