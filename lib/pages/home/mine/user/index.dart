import 'package:BYM/components/by_input_field.dart';
import 'package:BYM/get_pages.dart';
import 'package:BYM/pages/home/mine/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BYM/api/user.dart';

class UserController extends GetxController {
  String userId = '';
  TextEditingController nameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController timezoneCtl = TextEditingController();

  List timezoneList = [
    'UTC+00:00',
    'UTC+01:00',
    'UTC+02:00',
    'UTC+03:00',
    'UTC+03:30',
    'UTC+04:00',
    'UTC+04:30',
    'UTC+05:00',
    'UTC+05:30',
    'UTC+06:00',
    'UTC+06:30',
    'UTC+07:00',
    'UTC+08:00',
    'UTC+09:00',
    'UTC+10:00',
    'UTC+11:00',
    'UTC+12:00',
    'UTC-01:00',
    'UTC-02:00',
    'UTC-03:00',
    'UTC-03:30',
    'UTC-04:00',
    'UTC-04:30',
    'UTC-05:00',
    'UTC-05:30',
    'UTC-06:00',
    'UTC-06:30',
    'UTC-07:00',
    'UTC-08:00',
    'UTC-09:00',
    'UTC-10:00',
    'UTC-11:00',
    'UTC-12:00'
  ];

  void editUser() async {
    try {
      var res = await userApi.editUser(
        userId: userId,
        nickname: nameCtl.text,
        phone: phoneCtl.text,
        timezone: timezoneCtl.text,
      );

      // 修改成功后更新"我的"界面
      if(res['status'] == 200 && res['code'] == 1) {
        print('更新用户成功');
        Get.find<MineController>().getUser();
      }
    } catch (e) {
      print(e);
    }
  }
  void getUser() async {
    try {
      var data = (await userApi.getUser())['data'];

      userId = data['id'];
      nameCtl.text = data['nickname'];
      phoneCtl.text = data['phone'] ?? '';
      timezoneCtl.text = data['timezone'] ?? '';
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

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UserController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => BYRoute.back(),),
          title: const Text('用户信息'),
        ),
        body: Stack(
          children: [
            // 表单
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('用户名'),
                  const SizedBox(height: 12),
                  ByTextField(controller: _.nameCtl),
                  const SizedBox(height: 20),

                  const Text('电话'),
                  const SizedBox(height: 12),
                  ByTextField(controller: _.phoneCtl),
                  const SizedBox(height: 20),

                  const Text('时区'),
                  const SizedBox(height: 12),
                  BySelect(controller: _.timezoneCtl, options: _.timezoneList),
                ],
              ),
            ),

            // 按钮
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 40), // 边距
                child: ElevatedButton(
                  onPressed: () {
                    _.editUser();
                  },
                  child: const Text('保存'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
