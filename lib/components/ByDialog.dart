import 'package:flutter/material.dart';
//默认弹窗
class ByDialog extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String cancelText;
  final String confirmText;
  final VoidCallback onCancelPressed;
  final VoidCallback onConfirmPressed;

  const ByDialog({
    super.key,
    required this.titleText,
    required this.contentText,
    required this.cancelText,
    required this.confirmText,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFFFFF),
      title: Text(
        titleText,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      content: Text(
        contentText,
        style: TextStyle(fontSize: 16.0),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onCancelPressed,
          child: Text(
            cancelText,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Color(0xFF5475F8)),
          ),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFF5475F8),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextButton(
            onPressed: onConfirmPressed,
            child: Text(
              confirmText,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), // 这里添加圆角
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('data'),
          ],
        ),
      ),
    );
  }
}
