import 'package:BYM/utils/by_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnregisterPage extends StatelessWidget {
  const UnregisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Center(
                  child: SvgPicture.asset(
                    'assets/ic_fail.svg',
                    width: 50,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '注销后您的账号将发生如下变化:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Text(
                  '永久注销，无法登录',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  '注销本账号后，出法律法规及账号注销协议另有规定外，基于该账号的信息相关数据也将进行删除或者匿名化处理。您无法再检索、访问、获取、继续使用，前述其他信息包括但不限于:头像昵称、或使用中添加的电站信息及微逆信息等内容。',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Color(0xFF939393)),
                ),
                const SizedBox(height: 24),
                Text(
                  '此账号关联的信息将被删除',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  '1.该账号下电站数据',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  '2.EMU设备数据',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  '3.光伏板发电数据',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),

          // 按钮
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40), // 边距
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BYRoute.toNamed('/MineUnregisterConfirm', arguments: {});
                    },
                    child: const Text('我已知晓，确认注销'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '若想恢复数据，请联系平台方.',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF878787)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

