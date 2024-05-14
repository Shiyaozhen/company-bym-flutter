import 'package:flutter/material.dart';

class ChangeInfo extends StatefulWidget {
  const ChangeInfo({Key? key}) : super(key: key);

  @override
  _ChangeInfoState createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  TextEditingController _controllerPlant = TextEditingController();
  TextEditingController _controllerAccount = TextEditingController();
  bool _showClearPlantButton = false;
  bool _showClearAccountButton = false;
  @override
  void initState() {
    super.initState();
    _controllerPlant.addListener(() {
      setState(() {
        _showClearPlantButton = _controllerPlant.text.isNotEmpty;
      });
    }
    );
       _controllerAccount.addListener(() {
      setState(() {
        _showClearAccountButton = _controllerAccount.text.isNotEmpty;
      });
    }
    );
  }

  void _clearPlantTextField() {
    setState(() {
      _controllerPlant.clear();
      _showClearPlantButton = false;
    });
  }
  
   void _clearAccountTextField(){
    setState(() {
      _controllerAccount.clear();
      _showClearAccountButton = false;
    });
   }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '修改信息',
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
        padding:
            EdgeInsets.only(top: 16.0, bottom: 16.0, left: 13.0, right: 13.0),
        child: Column(
          children: [
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 15.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '电站名称',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 11.0, bottom: 22.0),
              child: TextField(
                controller: _controllerPlant,
                decoration: InputDecoration(
                  hintText: '请输入电站名称',
                  suffixIcon: _showClearPlantButton
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Color(0xFF7989B2)),
                          onPressed: _clearPlantTextField,
                        )
                      : null,
                ),
              ),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 15.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '国家',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 11.0, bottom: 22.0),
              child: TextField(
                enabled: false,
                // controller: _controller,
                decoration: InputDecoration(
                    hintText: '请选择国家',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF7989B2)),
                      onPressed: _clearPlantTextField,
                    )),
              ),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 15.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '*',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '时区',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 11.0, bottom: 22.0),
              child: TextField(
                enabled: false,
                // controller: _controller,
                decoration: InputDecoration(
                    hintText: '请选择时区',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF7989B2)),
                      onPressed: _clearPlantTextField,
                    )),
              ),
            ),
            Row(
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: 10.0,
                  baselineType: TextBaseline.alphabetic,
                  child: Text(
                    '图片',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
