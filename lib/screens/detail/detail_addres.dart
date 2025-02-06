import 'package:flutter/material.dart';

class DetailAddress extends StatelessWidget {
  final String address;

  const DetailAddress({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'Address: $address',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
