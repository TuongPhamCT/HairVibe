import 'package:flutter/material.dart';

class NoNetworkScreen extends StatefulWidget {
  const NoNetworkScreen({super.key});
  static const String routeName = 'no-network';

  @override
  State<NoNetworkScreen> createState() => _NoNetworkScreenState();
}

class _NoNetworkScreenState extends State<NoNetworkScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              color: Colors.white,
              size: 200,
            ),
            SizedBox(height: 20),
            Text(
              'There is no internet connnection',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
