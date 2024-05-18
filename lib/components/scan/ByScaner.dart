import 'package:BYM/components/ByDialog.dart';
import 'package:BYM/components/scan/scanner_button_widgets.dart';
import 'package:BYM/components/scan/scanner_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerListViewer extends StatefulWidget {
  const BarcodeScannerListViewer({Key? key}) : super(key: key);

  @override
  _BarcodeScannerListViewState createState() => _BarcodeScannerListViewState();
}

class _BarcodeScannerListViewState extends State<BarcodeScannerListViewer> {
  final MobileScannerController controller =
      MobileScannerController(torchEnabled: false);

  Barcode? _barcode;
  bool _showDialog = false;
  bool _isScanning = true;
  void _handleBarcode(BarcodeCapture barcodes) {
    if (!_isScanning) {
      return;
    }
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        if (_barcode?.displayValue?[8] == '1' ||
            _barcode?.displayValue?[8] == '4') {
          _showDialog = true;
          _isScanning = false;
        } else {
          _showDialog = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_showDialog) {
          showDialog(
        context: context,
        builder: (BuildContext context) {
          return ByDialog(
            titleText: '温馨提示',
            contentText: '扫码设备为终端设备(MI)，连接在通讯设备-网关(EMU)下面.请先添加网关！',
            cancelText: '',
            confirmText: '确认',
            onCancelPressed: () {
              Navigator.of(context).pop();
              _isScanning = true;
            },
            onConfirmPressed: () {
              print("执行退出登录的操作");
              Navigator.of(context).pop();
                 _isScanning = true;
            },
          );
        },
      );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '扫码添加设备',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
          ),
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _handleBarcode,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
          ),
          Column(
            children: [
              Container(child: _buildBarcode(_barcode)),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 0.0,
                        child: Text(
                          '找不到条形码',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                      Baseline(
                        baselineType: TextBaseline.alphabetic,
                        baseline: 19.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.help_outline,
                            size: 20,
                          ),
                          color: const Color(0xFFFFFFFF),
                          onPressed: NoFound,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35.0, right: 35.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '扫描设备的条形码，连接到BYM Cloud云平台管理系统，若没有条形码，请点击“手动输入”',
                    style: TextStyle(fontSize: 15.0, color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: 280,
                height: 160,
                // color: Colors.blue,
                child: Image.asset('assets/ic_scan_gif.gif'),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                child: Column(
                  children: [
                    ToggleFlashlightButton(controller: controller),
                    Text(
                      '闪光灯',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.border_color_outlined,
                            size: 28,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          '手动输入',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AnalyzeImageFromGalleryButton(controller: controller),
                        Text(
                          '识别照片',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void NoFound() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 350,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 23.0, left: 16.0, right: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        '条形码位置示意图',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 330,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F7FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 13.0,
                                bottom: 13.0,
                                left: 11.0,
                                right: 11.0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '1、Wi-Fi微逆(MI-W)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/ic_scan_wifi_tip.png',
                                    width: 236,
                                    height: 94,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Container(
                            width: 330,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F7FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 13.0,
                                bottom: 13.0,
                                left: 11.0,
                                right: 11.0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '2、网关(EMU)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/ic_scan_emu_tip.png',
                                    width: 236,
                                    height: 94,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Container(
                            width: 330,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F7FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 13.0,
                                bottom: 13.0,
                                left: 11.0,
                                right: 11.0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '3、微逆(MI)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/ic_scan_mi_tip.png',
                                    width: 236,
                                    height: 94,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                '知道了',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Color(0xFF5475F7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }
    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
