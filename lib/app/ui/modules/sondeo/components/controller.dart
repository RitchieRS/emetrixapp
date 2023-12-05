import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//Textfilelds
final textEditingControllerProvider =
    ProviderFamily<TextEditingController, int>((ref, index) {
  return TextEditingController();
});

//DateTime & GPS
class StringManager {
  String _myString;
  StringManager(this._myString);

  String get currentString => _myString;

  void updateString(String newString) {
    _myString = newString;
  }
}

final stringManagerProvider = ProviderFamily<StringManager, int>((ref, index) {
  return StringManager('');
});

//Timer
final stopwatchProviderFamily =
    ProviderFamily<StopwatchProvider, int>((ref, id) {
  return StopwatchProvider(id: id);
});

class StopwatchProvider with ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final int id;
  int _minutes = 0;
  int _seconds = 0;
  int _milliseconds = 0;

  StopwatchProvider({required this.id});

  Stopwatch get stopwatch => _stopwatch;

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        _minutes = _stopwatch.elapsed.inMinutes % 60;
        _seconds = _stopwatch.elapsed.inSeconds % 60;
        _milliseconds = _stopwatch.elapsedMilliseconds;
        notifyListeners();
      });
    }
  }

  int minutes() {
    return _minutes;
  }

  int seconds() {
    return _seconds;
  }

  int milliseconds() {
    return _milliseconds;
  }

  bool isRunning() {
    return _stopwatch.isRunning;
  }

  void reset() {
    _stopwatch.reset();
  }

  void stop() {
    _stopwatch.stop();
  }

  void stopStopwatch() {
    _timer?.cancel();
  }

  void resetStopwatch() {
    _stopwatch.reset();
    notifyListeners();
  }
}

final stringListProvider = ProviderFamily<List<String>, int>((ref, id) {
  return <String>[];
});

//Images & Photos
final imageFileProviderFamily = ProviderFamily<FileState?, int>((ref, id) {
  return FileState();
});

class FileState {
  File? file;

  readAsBytes() {
    return file?.readAsBytes();
  }
}

//Radios
final radiosProvider = ProviderFamily<IntManager, int>((ref, index) {
  return IntManager(0);
});

class IntManager {
  int _myInt;
  IntManager(this._myInt);

  int get currentValue => _myInt;

  void updateValue(int newInt) {
    _myInt = newInt;
  }
}

//RadiosMultiple
final radiosMultipleProvider = ProviderFamily<List<String>, int>((ref, id) {
  return <String>[];
});
