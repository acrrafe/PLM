import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}
bool _isAllSelected = true;
bool _isUnreadSelected = false;

class CustomButton{
  final String text;
  final Color textColor;
  final Color selectedColor;
  final Color unselectedColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.selectedColor,
    required this.unselectedColor,
  });
}
class Notification {
  final Widget icon;
  final String title;
  final String description;
  final String time;

  Notification({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
  });
}

class _NotificationWidgetState extends State<NotificationPage>{
  final List<Notification> notifications = [
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_kap.jpg')),
      title: 'Notification Title 1',
      description: 'This is a short description for Notification 1',
      time: '12:00 AM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_duj.jpg')),
      title: 'Notification Title 2',
      description: 'This is a short description for Notification 2',
      time: '2:00 AM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_romeo.jpg')),
      title: 'Notification Title 4',
      description: 'This is a short description for Notification 4',
      time: '3:00 AM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_kap.jpg')),
      title: 'Notification Title 5',
      description: 'This is a short description for Notification 5',
      time: '8:00 AM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_romeo.jpg')),
      title: 'Notification Title 6',
      description: 'This is a short description for Notification 6',
      time: '5:00 PM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_kap.jpg')),
      title: 'Notification Title 7',
      description: 'This is a short description for Notification 7',
      time: '1:00 PM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_duj.jpg')),
      title: 'Notification Title 8',
      description: 'This is a short description for Notification 8',
      time: '9:00 AM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_kap.jpg')),
      title: 'Notification Title 9',
      description: 'This is a short description for Notification 99',
      time: '10:00 AM',
    ),
    Notification(
      icon: const CircleAvatar(backgroundColor: Colors.grey, backgroundImage: AssetImage('images/ic_romeo.jpg')),
      title: 'Notification Title 10',
      description: 'This is a short description for Notification 10',
      time: '3:00 PM',
    ),
  ];
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
        title: const Text('NOTIFICATION',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // All and Unread Button
              Container(height: 40.0,
                decoration: BoxDecoration(
                  color: _isAllSelected ? const Color(0xFFF4E4C4) : Colors.transparent, // Check if All is selected
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isAllSelected = true;
                      _isUnreadSelected = false;
                    });
                  },
                  child: Text('All',
                    style: TextStyle(color: _isAllSelected ? const Color(0xFFD5A106)  : Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Container(height: 40.0,
                decoration: BoxDecoration(
                  // check if unread is selected
                  color: _isUnreadSelected ? const Color(0xFFF4E4C4) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isAllSelected = false;
                      _isUnreadSelected = true;
                    });
                  },
                  child: Text('Unread',
                    style: TextStyle(color: _isUnreadSelected ? const Color(0xFFD5A106)  : Colors.black ,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Padding(padding: EdgeInsets.only(left: 16),
                child: Text('Today',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: _isAllSelected ? (index.isOdd ? Colors.blue[50] : Colors.white) : (_isUnreadSelected ? Colors.blue[50] : null),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [

                      Container(width: 48, height: 48,
                        decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                        child: notifications[index].icon),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notifications[index].title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notifications[index].description,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Text(notifications[index].time,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}