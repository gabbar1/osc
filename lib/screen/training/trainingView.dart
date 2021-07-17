import 'package:flutter/material.dart';
import 'package:upen/commonWidget/commonWidget.dart';

class TrainingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CommonText(text: "Training"),
      ),
    );
  }
}
