import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/shared/components/constants.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(
        title: const Text(
          'Contact us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                '* Phone: 01201286638',
                style: TextStyle(
                  fontSize: 24,
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                '* Email: mhmdalghnam489@gamil.com',
                style: TextStyle(
                  fontSize: 20,
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
