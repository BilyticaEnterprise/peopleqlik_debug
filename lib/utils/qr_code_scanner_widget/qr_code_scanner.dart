import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/static_streams.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Appbars/app_bar.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    // final message =
    // // ignore: lines_longer_than_80_chars
    //     'Hey this is a QR code. Change this value in the main_screen.dart file.';
    //
    // final qrFutureBuilder = FutureBuilder<ui.Image>(
    //   future: _loadOverlayImage(),
    //   builder: (ctx, snapshot) {
    //     final size = 280.0;
    //     if (!snapshot.hasData) {
    //       return Container(width: size, height: size);
    //     }
    //     return CustomPaint(
    //       size: Size.square(size),
    //       painter: QrPainter(
    //         data: message,
    //         version: QrVersions.auto,
    //         eyeStyle: const QrEyeStyle(
    //           eyeShape: QrEyeShape.square,
    //           color: Color(0xff128760),
    //         ),
    //         dataModuleStyle: const QrDataModuleStyle(
    //           dataModuleShape: QrDataModuleShape.circle,
    //           color: Color(0xff1a5441),
    //         ),
    //         // size: 320.0,
    //         embeddedImage: snapshot.data,
    //         embeddedImageStyle: QrEmbeddedImageStyle(
    //           size: Size.square(60),
    //         ),
    //       ),
    //       child: QrImage(
    //         data: 'thihgvhgv',
    //       ),
    //     );
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(MyColor.colorWhite),
          elevation: 2,
          titleSpacing: 0,
          title: AppBarWidget('Scan QR Code')
      ),
      body: ChangeNotifierProvider<QrCodeResults>(
        create: (_) => QrCodeResults(),
        builder: (context, child) {
          return const BodyData();
        }
      ),
    );
  }

  // Future<ui.Image> _loadOverlayImage() async {
  //   final completer = Completer<ui.Image>();
  //   final byteData = await rootBundle.load('assets/avatar.png');
  //   ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
  //   return completer.future;
  // }
}

class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QrCodeResults>(
      builder: (contextt, data, child) {
        // if(data.result!=null&&data.result?.code!=null&&data.result!.code==Provider.of<SettingsController>(context,listen: false).settingsResultSet?.employeeCompanyData?.qrCode)
        //   {
        //     if(mounted)goBack();
        //     return Center(child: NotAvailable('success', GetVariable.scannedSuccessHeader, GetVariable.scannedSuccessAnswer,topMargin: ScreenSize(context).heightOnly( 0),width: ScreenSize(context).heightOnly( 10),));
        //   }
        // else
        //   {
            return Stack(
              children: [
                Column(
                  children: <Widget>[
                    Expanded(flex: 4, child: _buildQrView(context)),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    bottom: true,
                    top: true,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: window.viewPadding.bottom>0?0:ScreenSize(context).heightOnly( 3)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Material(
                              color: const Color(MyColor.colorPrimary),
                              child: InkWell(
                                splashColor: const Color(MyColor.colorGrey0),
                                onTap: () async {
                                  try{
                                    await controller?.toggleFlash();
                                    data.justNotify();
                                  }catch(e)
                                  {
                                    data.justNotify();
                                  }
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2.2)),
                                    child: Icon(MdiIcons.flash,color: const Color(MyColor.colorWhite),size: ScreenSize(context).heightOnly( 3.2),)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenSize(context).heightOnly( 3),),
                          ClipOval(
                            child: Material(
                              color: const Color(MyColor.colorRed),
                              child: InkWell(
                                splashColor: const Color(MyColor.colorGrey0),
                                onTap: () async {
                                  await controller?.flipCamera();
                                  data.justNotify();
                                },
                                child: Padding(
                                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2.2)),
                                    child: Icon(MdiIcons.cameraSwitch,color: const Color(MyColor.colorWhite),size: ScreenSize(context).heightOnly( 3.2),)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
     //     }
      }
    );
  }
  void goBack()
  {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Navigator?.popUntil(Provider.of<CheckInOutModelStarter>(context,listen: false).dashBoardContext??context,ModalRoute.withName(CurrentPage.BottomBarPage));
      // OpenStreams.qrCodeStream.add(true);
    });
    // Future.delayed(const Duration(seconds: 2),() async {
    //
    // });
  }
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.height/100*34
        : MediaQuery.of(context).size.height/100*54;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
        Provider.of<QrCodeResults>(context,listen: false).update(scanData);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Required camera permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
class QrCodeResults extends GetChangeNotifier
{
  Barcode? result;
  void update(Barcode? result)
  {
    this.result = result;
    PrintLogs.printLogs(result?.code);
    notifyListeners();
  }
  void justNotify()
  {
    notifyListeners();
  }
}