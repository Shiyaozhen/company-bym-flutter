import 'package:BYM/api/user.dart';
import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineController extends GetxController {
  Image? image;
  String nickname = '';
  String email = '';

  void getUser() async {
    try {
      var data = (await userApi.getUser())['data'];

      nickname = data['nickname'];
      email = data['email'] ?? '';

      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getUser();

    super.onInit();
  }
}

class Mine extends StatelessWidget {
  const Mine({super.key, required Map<String, dynamic> arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Ink(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.83],
            colors: [
              Color(0xFFD6DDFF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: ListView(
          children: [
            const ImageSection(),
            Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  MineListItem(
                    leading: Icon(Icons.lock_outline),
                    title: '修改密码',
                    trailing: Icon(Icons.arrow_forward_ios),
                    route: '/ChangePwd',
                  ),
                  Divider(),
                  MineListItem(
                    leading: Icon(Icons.language),
                    title: '设置语言',
                    trailing: Icon(Icons.arrow_forward_ios),
                    route: '/Language',
                  ),
                  Divider(),
                  MineListItem(
                    leading: Icon(Icons.mail_outline),
                    title: '绑定邮箱',
                    trailing: Icon(Icons.arrow_forward_ios),
                    route: '/BindEmail',
                  ),
                  Divider(),
                  MineListItem(
                    leading: Icon(Icons.group_outlined),
                    title: '绑定经销商',
                    trailing: Icon(Icons.arrow_forward_ios),
                    route: '/BindAgent',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const MineListItem(
                leading: Icon(Icons.phone_outlined),
                title: '联系我们',
                trailing: Icon(Icons.arrow_forward_ios),
                route: '/Connect',
              ),
            ),
            const SizedBox(height: 20),
            Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const MineListItem(
                leading: Icon(Icons.more_horiz_outlined),
                title: '更多',
                trailing: Icon(Icons.arrow_forward_ios),
                route: '/MineMore',
              ),
            ),
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
    return GetBuilder(
      init: MineController(),
      builder: (_) => Container(
        margin: const EdgeInsets.only(top: 40, bottom: 24),
        child: Row(
          children: [
            InkWell(
              onTap: () => BYRoute.toNamed('/User'),
              child: SizedBox(
                width: 70,
                height: 70,
                child: Image.network('https://picsum.photos/250?image=9'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_.nickname),
                const SizedBox(height: 12),
                Text(_.email),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MineListItem extends StatelessWidget {
  final Icon leading;
  final String title;
  final Icon trailing;
  final String route;

  const MineListItem({
    super.key,
    required this.leading,
    required this.title,
    required this.trailing,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BYRoute.toNamed(route, arguments: {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: leading,
          title: Text(title),
          trailing: trailing,
        ),
      ),
    );
  }
}

