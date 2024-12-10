import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // SystemChrome.setSystemUIOverlayStyle(
  //     );

  runApp(const IsolateApp());
}

class IsolateApp extends StatelessWidget {
  const IsolateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '👾',
                style: TextStyle(fontSize: 100),
              )
                  .animate(
                    onPlay: (controller) =>
                        controller.loop(count: 4, reverse: true),
                  )
                  .rotate(begin: 0, end: 2)
                  .then(delay: 400.ms)
                  .shimmer(delay: 300.ms, duration: 500.ms)
                  .shake(hz: 2.2, curve: Curves.easeInOut)
                  .scaleXY(begin: 0.5, end: 1.1, duration: 600.ms)
                  .then(delay: 650.ms)
                  .scaleXY(end: 1 / 1.1),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createIsolate();
          },
          child: const Icon(Icons.sixty_fps_select_outlined),
        ),
      ),
    );
  }

  void createIsolate() async {
    // main thuc thi
    var receiverport = ReceivePort();
    var newIsolate = await Isolate.spawn(taskSum, receiverport.sendPort);
    Future.delayed(const Duration(seconds: 2), () {
      newIsolate.kill(priority: Isolate.immediate);

      print('da kill new isolate');
    });

    receiverport.listen((data) {
      print(data);
    });
  }

  static void taskSum(SendPort sendPort) {
    // new isolate
    int total = 0;
    for (int i = 0; i < 707989898898799999; i++) {
      total += i;
    }
    sendPort.send(total);
  }
}
