import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:study/utils/meta/text.dart';

const Duration micTimoutDuration = Duration(seconds: 4);

class MicInputWidget extends StatefulWidget {
  final Function(String text) onStopped;
  final Function() onCancelled;
  const MicInputWidget(
      {Key? key, required this.onStopped, required this.onCancelled})
      : super(key: key);

  @override
  State<MicInputWidget> createState() => _MicInputWidgetState();
}

class _MicInputWidgetState extends State<MicInputWidget> {
  String _lastWords = '';
  bool _speechListening = false;
  final SpeechToText _speechToText = SpeechToText();

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _timer = Timer(micTimoutDuration, () {
      widget.onCancelled();
    });
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    bool hasPermission = await _requestPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(MetaText.of(context).micPermissionNotGiven)));
      return;
    }

    if (!_speechToText.isAvailable) {
      await _speechToText.initialize();
    }
    setState(() {});
    _startListening();
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    _speechListening = true;
    _lastWords = '';
    setState(() {});
  }

  void _stopListening() async {
    _speechListening = false;
    setState(() {});
    widget.onStopped(_lastWords);
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _timer.cancel();
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              MetaText.of(context).listening,
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          if (_speechListening)
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                _lastWords,
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 12),
          _speechListening
              ? FloatingActionButton(
                  onPressed: _lastWords.isEmpty ? null : _stopListening,
                  tooltip: 'Listen',
                  backgroundColor: _lastWords.isEmpty ? Colors.teal : null,
                  child: const Icon(Icons.send),
                )
              : const Center(child: CircularProgressIndicator.adaptive()),
          CupertinoButton(
              child: Text(
                MetaText.of(context).cancel,
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    color: CupertinoColors.destructiveRed),
              ),
              onPressed: () {
                widget.onCancelled();
              })
        ],
      ),
    );
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }
}
