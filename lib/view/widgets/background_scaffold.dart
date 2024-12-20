import 'package:flutter/material.dart';

class BackgroundScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  const BackgroundScaffold({super.key, required this.body, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
