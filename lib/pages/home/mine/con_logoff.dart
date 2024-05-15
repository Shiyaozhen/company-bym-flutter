import 'package:flutter/material.dart';

class Conlogoff extends StatefulWidget {
  const Conlogoff({Key? key}) : super(key: key);

  @override
  _ConlogoffState createState() => _ConlogoffState();
}

class _ConlogoffState extends State<Conlogoff> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '账号注销',
          textAlign: TextAlign.center,
          style:  Theme.of(context).textTheme.headlineMedium,
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '账号安全验证',
                        style:  Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '请输入登录密码',
                        style:  Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: Color(0xFF7989B2)),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton:  Container(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: () {
                  print('密码为: 123');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF5475F8)),
                  foregroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(45.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0), // 设置圆角半径为20.0
                    ),
                  ),
                ),
                child: Text('确认注销',style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold,color: Color(0xFFFFFFFF))),
              ),
            )),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
