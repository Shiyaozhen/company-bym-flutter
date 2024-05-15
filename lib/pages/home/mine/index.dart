import 'package:BYM/get_pages.dart';
import 'package:flutter/material.dart';

class Mine extends StatelessWidget {
  const Mine({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: const Color.fromRGBO(247, 249, 255, 1),
        dividerTheme: const DividerThemeData(
          color: Color.fromRGBO(121, 137, 178, 0.1),
          endIndent: 20,
          indent: 20,
          space: 0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.indigo,
          size: 18,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Color.fromRGBO(121, 137, 178, 1),
        ),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
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
              const SizedBox(
                height: 20,
              ),
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
              const SizedBox(
                height: 20,
              ),
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
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: Image.network('https://picsum.photos/250?image=9'),
          ),
          const SizedBox(
            width: 20,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('用户名'),
              Text('example@email.com'),
            ],
          ),
        ],
      ),
    );
  }
}

class MineListItem extends StatelessWidget {
  const MineListItem({
    super.key,
    required this.leading,
    required this.title,
    required this.trailing,
    required this.route,
  });

  final Icon leading;
  final String title;
  final Icon trailing;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BYRoute.toNamed(route, arguments: {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: leading,
          title: Text(
            title,
            style: TextStyle(),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}

