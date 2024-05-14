import 'package:flutter/material.dart';

class ApplyBindingRejected extends StatelessWidget {
  const ApplyBindingRejected({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('申请绑定'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ImageSection(),
                TextSection(),
              ],
            ),
            ButtonSection(),
          ],
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 100),
      child: const Column(
        children: [
          Image(
            width: 100,
            height: 100,
            image: AssetImage('assets/image/mine/bindAgent/rejected.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '已拒绝',
            style: TextStyle(
              color: Color.fromRGBO(240, 175, 105, 1),
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatefulWidget {
  const TextSection({super.key});

  @override
  State<TextSection> createState() =>
      _TextSectionState();
}

class _TextSectionState extends State<TextSection> {
  final textController = TextEditingController();

  void _printLatestValue() {
    final text = textController.text;

    print(text);
  }

  @override
  void initState() {
    super.initState();

    textController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (String value) {
        print(value);
      },
      decoration: const InputDecoration(
        hintText: '请输入经销商账号',
      ),
      controller: textController,
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 16)),
            ),
            child: const Text('返回'),
          ),
        ),
      ],
    );
  }
}
