import 'package:flutter/material.dart';

void main() {
  runApp(const MiCardApp());
}

class MiCardApp extends StatelessWidget {
  const MiCardApp({super.key});

  static const Color primaryColor = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/rick.jpg'),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Phan Thanh Lợi',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'FLUTTER DEVELOPER',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20,
                    color: Colors.deepOrange.shade100,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 20,
                  width: 150,
                  child: Divider(color: Colors.deepOrange.shade100),
                ),

                const ContactCard(
                  icon: Icons.phone,
                  text: '+84 69 420 8386',
                  fontSize: 20,
                ),

                const ContactCard(
                  icon: Icons.email,
                  text: 'loipt.23it@vku.udn.vn',
                  fontSize: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final double fontSize;

  const ContactCard({
    super.key,
    required this.icon,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepOrange),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.deepOrange.shade900,
            fontFamily: 'Source Sans Pro',
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
