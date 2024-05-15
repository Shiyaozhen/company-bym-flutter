import 'package:flutter/material.dart';

import 'review.dart';

class BindAgent extends StatelessWidget {
  const BindAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            '绑定经销商',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Image(
                width: 60,
                height: 60,
                image: AssetImage('assets/image/mine/bindAgent/owner.png'),
              ),
            ],
          ),
          Icon(Icons.link_outlined),
          Column(
            children: [
              Image(
                width: 60,
                height: 60,
                image: AssetImage('assets/image/mine/bindAgent/agent.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatefulWidget {
  const TextSection({super.key});

  @override
  State<TextSection> createState() => _TextSectionState();
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApplyBindingReview(),
                ),
              );
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                  (states) => const EdgeInsets.symmetric(vertical: 16)),
            ),
            child: const Text('提交'),
          ),
        ),
      ],
    );
  }
}
