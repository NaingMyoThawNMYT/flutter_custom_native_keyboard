import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platformChannelName = 'fkeyboard';
const platformChannel = MethodChannel(platformChannelName);
const platformMethodName = 'start';

const keyEventUp = 4294968072; // 92;
const keyEventDown = 4294968071; // 93;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Native Keyboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Native Keyboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status = '';

  int _keyEvent = keyEventUp;

  Future<void> _openKeyboardSettings() async {
    try {
      _status = await platformChannel.invokeMethod(
        platformMethodName,
      );
    } catch (e) {
      _status = e.toString();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(_status),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                alignment: _keyEvent == keyEventUp
                    ? Alignment.topCenter
                    : Alignment.bottomCenter,
                child: const FlutterLogo(size: 100),
              ),
            ),
            const SizedBox(height: 16),
            RawKeyboardListener(
              focusNode: FocusNode(),
              child: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Type Here'),
              ),
              onKey: (event) {
                _keyEvent = event.data.logicalKey.keyId;

                setState(() {});
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openKeyboardSettings,
        tooltip: 'Open Keyboard',
        child: const Icon(Icons.keyboard),
      ),
    );
  }
}
