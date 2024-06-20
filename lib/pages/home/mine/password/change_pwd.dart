import 'package:flutter/material.dart';

class ChangePwd extends StatefulWidget {
  const ChangePwd({Key? key}) : super(key: key);

  @override
  _ChangePwdState createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  bool isObscure_old = true;
  bool isObscure_new = true;
  bool isObscure_con_new = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '修改密码',
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
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 0, left: 13.0, right: 13.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '原密码',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextField(
                obscureText: isObscure_old,
                decoration: InputDecoration(
                  hintText: '请输入原密码',
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscure_old
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF7989B2)),
                    onPressed: () {
                      setState(() {
                        isObscure_old = !isObscure_old;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '请输入新密码',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextField(
                obscureText: isObscure_new,
                decoration: InputDecoration(
                  hintText: '请输入新密码',
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscure_new
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF7989B2)),
                    onPressed: () {
                      setState(() {
                        isObscure_new = !isObscure_new;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '请确认新密码',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextField(
                obscureText: isObscure_con_new,
                decoration: InputDecoration(
                  hintText: '请确认新密码',
                  suffixIcon: IconButton(
                    icon: Icon(
                        isObscure_con_new
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF7989B2)),
                    onPressed: () {
                      setState(() {
                        isObscure_con_new = !isObscure_con_new;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ElevatedButton(
              onPressed: () {},
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
              child: Text('保存',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF))),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
