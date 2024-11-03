import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://th.bing.com/th?id=OIP.NqY3rNMnx2NXYo3KJfg43gHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2"), // Replace with your asset image
                backgroundColor: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle add news
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Add News'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.white),
                    title: const Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(color: Colors.white),
                  ListTile(
                    leading: const Icon(Icons.history, color: Colors.white),
                    title: const Text(
                      'Activities',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(color: Colors.white),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.white),
                    title: const Text(
                      'Help & Support',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(color: Colors.white),
                  ListTile(
                    leading:
                        const Icon(Icons.notifications, color: Colors.white),
                    title: const Text(
                      'Notifications',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(color: Colors.white),
                  ListTile(
                    leading: const Icon(Icons.event_note, color: Colors.white),
                    title: const Text(
                      'Terms & conditions',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(color: Colors.white),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                  const Divider(color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
