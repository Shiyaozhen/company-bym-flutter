import 'package:flutter/material.dart';

class MineFeedback extends StatefulWidget {
  const MineFeedback({Key? key}) : super(key: key);

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<MineFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '意见反馈',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Color(0xFF383838)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF383838),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
