import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:developer' as developer;
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


  /// The [SharedPreferences] key to access the alarm fire count.
     const String countKey = 'count';

    /// The name associated with the UI isolate's [SendPort].
    const String isolateName = 'isolate';

    /// A port used to communicate from a background isolate to the UI isolate.
    ReceivePort port = ReceivePort();

    /// Global [SharedPreferences] object.
    SharedPreferences? prefs;

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
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _milliseconds = 0;
    late Isolate _isolate;
  late ReceivePort _receivePort;
  bool _isRunning = false;
  Duration _elapsedTime = Duration(seconds: 0);
  
  StopwatchProvider({required this.id});

  Stopwatch get stopwatch => _stopwatch;

  void start() async {

    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_isolateEntryPoint, _receivePort.sendPort);
    _receivePort.listen((data) {
       _isRunning = true;
      if (data is int) {
        _elapsedTime = Duration(seconds: data);
        _hours = _elapsedTime.inHours % 60;
        _minutes = _elapsedTime.inMinutes % 60;
        _seconds = _elapsedTime.inSeconds % 60;
        _milliseconds = _elapsedTime.inMilliseconds;
        notifyListeners();
      }
    });
  }

   static void _isolateEntryPoint(SendPort sendPort) {
    int elapsedSeconds=0;
    
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      elapsedSeconds++;
      sendPort.send(elapsedSeconds);
    });
  }

  int hours() {
    return _hours;
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
    return _isRunning;
  }

  void reset() {
    _isRunning = false;
    _isolate.kill(priority: Isolate.immediate);
     start();
    _stopwatch.reset();
  }

  void awaitIso() {
    _isRunning = false;
    _isolate.kill(priority: Isolate.immediate);
    _minutes = 0;
    _seconds = 0;
    _milliseconds = 0;
  }

  void stop() {
    logger.i("Timer Cancel ");
    _isRunning = false;
    _timer?.cancel();
    _isolate.kill(priority: Isolate.immediate);
     _minutes = 0;
    _seconds = 0;
    _milliseconds = 0;
  }

  void stopStopwatch() {
    _timer?.cancel();
     _isolate.kill(priority: Isolate.immediate);
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
