import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapGuidePage extends StatefulWidget {
  @override
  _MapGuidePageState createState() => _MapGuidePageState();
}

// WebView Class
class WebViewLauncher extends StatefulWidget {
  final String url;
  const WebViewLauncher({required this.url});
  @override
  _WebViewLauncherState createState() => _WebViewLauncherState();
}

class _WebViewLauncherState extends State<WebViewLauncher> {
  bool _isLoading = true;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
        backgroundColor: const Color(0xFF343BA6),
        actions: const <Widget>[
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebView(initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
            },
            onPageFinished: (finish) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) {
              print('Webview error: ${error.description}');
            },
          ),
          _isLoading ? const Center(
            child: CircularProgressIndicator(),
          )
              : Container(),
        ],
      ),
    );
  }
}

class _MapGuidePageState extends State<MapGuidePage> {
  GlobalKey _imageKey = GlobalKey();
  double _imageScale = 1.0;

  TransformationController _transformationController =
  TransformationController();

  void _zoomImage() {
    setState(() {
      _imageScale = _imageScale == 1.0 ? 3.0 : 1.0;
      _transformationController.value =
      Matrix4.identity()
        ..scale(_imageScale);
    });
  }


  Future<void> _downloadImage() async {
    RenderObject? boundary = _imageKey.currentContext?.findRenderObject();
    ui.Image? image;
    print(image);
    print("BOUNDARY TYPE: ${boundary.runtimeType}");
    if (boundary is RenderRepaintBoundary) {
      RenderRepaintBoundary repaintBoundary = boundary;
      image = await repaintBoundary.toImage(pixelRatio: 3.0);
      print("IMAGE: $image"); // Add this line to check the value of image
    }

    if (image != null) {
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final appDocDir = await getApplicationDocumentsDirectory();
      final file = File('${appDocDir.path}/image.png');
      await file.writeAsBytes(pngBytes);

      final result = await ImageGallerySaver.saveImage(pngBytes);
      if (result['isSuccess']) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Image Saved'),
                content: Text('The image has been saved to your gallery.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MAP AND GUIDE'),
        backgroundColor: Color(0xFF343BA6),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'images/plm_overview.jpg',
                      // Replace with the actual path to your image
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'BUILDING OVERVIEW',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Use this as your guide when you enter Pamantasan.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Note: click the icon to zoom or download the image',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 16),
                            RepaintBoundary(
                              key: _imageKey,
                              child: Stack(
                                children: [
                                  InteractiveViewer(
                                    transformationController: _transformationController,
                                    onInteractionUpdate: (details) {
                                      setState(() {
                                        _imageScale = _transformationController.value.getMaxScaleOnAxis();
                                      });
                                    },
                                    child: Image.asset(
                                      'images/ic_plm_map.png',
                                      // Replace with the actual path to your image
                                      fit: BoxFit.fill,
                                      width: 300,
                                      height: 300,
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          constraints: BoxConstraints(
                                            maxWidth: 38,
                                            maxHeight: 38,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.zoom_in),
                                            onPressed: _zoomImage,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          constraints: BoxConstraints(
                                            maxWidth: 38,
                                            maxHeight: 38,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.file_download),
                                            onPressed: _downloadImage,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Click the icon to view it in google maps.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 8, right: 16, bottom: 10),
                      child: GestureDetector(
                        onTap: _launchLocatePLM,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF343BA6),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'images/plm_map.png',
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _launchLocatePLM()  {
    const url = 'https://www.google.com.ph/maps/place/Plm/@14.5866826,120.9765389,19.08z/data=!4m6!3m5!1s0x3397ca3ccae52fb5:0xe17951ed729cd353!8m2!3d14.5868339!4d120.9764421!16s%2Fg%2F11c1rtp04d';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewLauncher(url: url),
      ),
    );
  }
}