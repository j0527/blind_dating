import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestUser extends StatefulWidget {
  const TestUser({super.key});

  @override
  State<TestUser> createState() => _TestUserState();
}

class _TestUserState extends State<TestUser> {

final _db = FirebaseFirestore.instance;







  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}