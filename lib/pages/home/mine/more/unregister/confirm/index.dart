import 'package:BYM/components/by_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:BYM/get_pages.dart';

class UnregisterController extends GetxController {
  TextEditingController controller = TextEditingController();
}

class UnregisterConfirmPage extends StatelessWidget {
  const UnregisterConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: UnregisterController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('账号注销'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => BYRoute.back(),
          ),
        ),
        body: Stack(
          children: [
            // 表单
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '账号安全验证',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '请输入登录密码',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 24),
                  ByPasswordField(controller: _.controller),
                ],
              ),
            ),

            // 按钮
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: ElevatedButton(
                  onPressed: () {
                    print(_.controller.text);
                  },
                  child: const Text('确认注销'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

