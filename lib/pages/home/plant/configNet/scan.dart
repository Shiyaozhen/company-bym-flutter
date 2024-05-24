import 'package:BYM/components/scan/ByScaner.dart';
import 'package:flutter/widgets.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //1.wifi版/普通网关  2.微逆
      child: BarcodeScannerListViewer(type: '1'),
    );
  }
}
