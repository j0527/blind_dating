import 'package:blind_dating/view/appbarWidget.dart';
import 'package:blind_dating/components/paymentsWidget.dart';
import 'package:flutter/material.dart';

class PayMentsPage extends StatelessWidget {
  const PayMentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PayMentsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
