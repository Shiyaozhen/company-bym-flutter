import 'package:BYM/utils/by_util.dart';
import 'package:flutter/material.dart';
import 'package:BYM/generated/l10n.dart';
import 'package:BYM/api/app.dart';
import 'package:BYM/utils/storage.dart';

// 页面容器
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 用户名
  final TextEditingController _usernameController = TextEditingController();
  // 密码
  final TextEditingController _passwordController = TextEditingController();

  // 登录
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    appApi.login(username, password);
  }

  @override
  void initState(){
    super.initState();

    _usernameController.text = Storage.instance?.getString('username') ?? '';
    _passwordController.text = Storage.instance?.getString('password') ?? '';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Logo(),
            UsernameTextField(controller: _usernameController),
            const SizedBox(
              height: 20,
            ),
            PasswordTextField(controller: _passwordController),
            const SizedBox(
              height: 20,
            ),
            const TextButtonRow(),
            const SizedBox(
              height: 45,
            ),
            const PrivacyRow(),
            const SizedBox(
              height: 20,
            ),
            LoginButton(onPressed: _login),
            const SizedBox(
              height: 20,
            ),
            const ExperiencePowerStation(),
          ],
        ),
      ),
    );
  }
}

// LOGO
class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/ic_logo.png',
            width: 60,
            height: 69,
          ),
          Text(
            'BYM Cloud',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

// 邮箱
class UsernameTextField extends StatefulWidget {
  final TextEditingController controller;

  const UsernameTextField({
    required this.controller,
    super.key,
  });

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  bool _showClearButton = false;

  void _clearTextField() {
    setState(() {
      widget.controller.clear();
      _showClearButton = false;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _showClearButton = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 37.0, bottom: 7.0),
            child: Text(
              S.of(context).email,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: S.of(context).email_hint,
            suffixIcon: _showClearButton
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Color(0xFF7989B2)),
                    onPressed: _clearTextField,
                  )
                : null,
          ),
        )
      ],
    );
  }
}

// 密码
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(S.of(context).password,
              style: Theme.of(context).textTheme.displayLarge),
        ),
        TextField(
          controller: widget.controller,
          obscureText: isObscure,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF7989B2),
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              hintText: S.of(context).password_hint),
        )
      ],
    );
  }
}

// 立即注册、忘记密码
class TextButtonRow extends StatelessWidget {
  const TextButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            BYRoute.toNamed('/SignUp', arguments: {});
          },
          child: Text(
            S.of(context).register,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: const Color(0xFF5475F7)),
          ),
        ),
        Text(
          '${S.of(context).forget_password}?',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: const Color(0xFF5475F7)),
        ),
      ],
    );
  }
}

// 隐私协议同意
class PrivacyRow extends StatefulWidget {
  const PrivacyRow({super.key});

  @override
  State<PrivacyRow> createState() => _PrivacyRowState();
}

class _PrivacyRowState extends State<PrivacyRow> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
          shape: const CircleBorder(),
          activeColor: const Color(0xFF5475F7),
          visualDensity: const VisualDensity(
            horizontal: -4.0,
            vertical: -4.0,
          ),
        ),
        Text(S.of(context).read_and_agree,
            style: Theme.of(context).textTheme.displayLarge),
        Text(
          S.of(context).privacy,
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: const Color(0xFF5475F7)),
        ),
      ],
    );
  }
}

// 登录按钮
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        S.of(context).login,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold, color: const Color(0xFFFFFFFF)),
      ),
    );
  }
}

// 体验电站
class ExperiencePowerStation extends StatelessWidget {
  const ExperiencePowerStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).experience_power_station,
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: const Color(0xFF5475F7)),
    );
  }
}
