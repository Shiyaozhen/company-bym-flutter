import 'package:flutter/material.dart';

import '../themes/colors.dart';

// 普通输入框
class ByTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const ByTextField({
    super.key,
    required this.controller,
    this.hintText = '',
  });

  @override
  State<ByTextField> createState() => _ByTextFieldState();
}

class _ByTextFieldState extends State<ByTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.controller.text.isNotEmpty ? IconButton(
          icon: const Icon(
            Icons.clear,
            color: Color(0xFF7989B2),
          ),
          onPressed: () {
            setState(() {
              widget.controller.text = '';
            });
          },
        ) : null,
      ),
      onChanged: (text) {
        // 不需要做些什么，只是需要调用这个函数来更新界面
        setState(() {});
      },
      onSubmitted: (text) {},
    );
  }
}


// 密码输入框
class ByPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const ByPasswordField({
    super.key,
    required this.controller,
    this.hintText = '',
  });

  @override
  State<ByPasswordField> createState() => _ByPasswordFieldState();
}

class _ByPasswordFieldState extends State<ByPasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xFF7989B2),
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      onChanged: (text) {},
      onSubmitted: (text) {},
    );
  }
}


// 右侧有按钮的输入框
class ByButtonTextField extends StatefulWidget {
  final TextEditingController controller;
  final Widget? suffix;
  final String hintText;
  final bool readonly;

  const ByButtonTextField({
    super.key,
    required this.controller,
    this.suffix,
    this.hintText = '',
    this.readonly = false,
  });

  @override
  State<ByButtonTextField> createState() => _ByButtonTextFieldState();
}

class _ByButtonTextFieldState extends State<ByButtonTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.suffix,
      ),
      readOnly: widget.readonly,
      onChanged: (text) {},
      onSubmitted: (text) {},
    );
  }
}

// 选择框
class BySelect extends StatelessWidget {
  final TextEditingController controller;
  final List options;
  final bool readonly;

  const BySelect({
    super.key,
    required this.controller,
    this.options = const [],
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readonly,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            // 获取当前选中的值的索引
            int currentIndex = options.indexOf(controller.text);
            // 创建 ScrollController 并设置初始滚动位置
            ScrollController scrollController = ScrollController(
              initialScrollOffset: currentIndex * 48.0, // 每个 ListTile 的高度为 48.0
            );

            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 250.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.expand_more),
                        ),
                      ),
                      Expanded(
                        child: options.isEmpty
                            ? const Center(
                                child: Text('没有可用的选项'),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(options[index]),
                                    tileColor: index == currentIndex ? ByColors.bg1 : null,
                                    onTap: () {
                                      Navigator.pop(context);
                                      controller.text = options[index];
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.expand_more),
        ),
      ),
    );
  }
}


