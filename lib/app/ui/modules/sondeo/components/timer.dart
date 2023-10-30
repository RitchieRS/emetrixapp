import 'dart:async';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTimer extends ConsumerStatefulWidget {
  const MyTimer({
    super.key,
    required this.pregunta,
    required this.times,
    this.mandatory = false,
  });
  final String pregunta;
  final int times;
  final bool mandatory;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyTimerState();
}

class _MyTimerState extends ConsumerState<MyTimer>
    with SingleTickerProviderStateMixin {
  int _minutes = 0;
  int _seconds = 0;
  int _milliseconds = 0;
  int _laps = 0;
  final Stopwatch _stopwatch = Stopwatch();
  final List<String> _lapTimes = [];

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        _handleLaps();
        debugPrint('Tap Laps: $_laps');
        debugPrint('Laps list: $_lapTimes');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: widget.mandatory ? c.errorLight : c.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(widget.pregunta, style: t.subtitle),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              style: const TextStyle(fontSize: 48.0),
              _formatTime(_minutes, _seconds, _milliseconds),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _lapTimes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_lapTimes[index]),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _handleLaps() {
    if (!_stopwatch.isRunning && _lapTimes.length < widget.times) {
      _startTimer();
      return;
    }
    if (_stopwatch.isRunning && _lapTimes.length < widget.times) {
      _takeLap();
      _restartTimer();
      return;
    }
    if (_stopwatch.isRunning && _lapTimes.length == widget.times) {
      _takeLap();
      _stopTimer();
      return;
    }

    _resetLaps();
    _startTimer();
  }

  void _resetLaps() {
    setState(() {
      _laps = 0;
      _lapTimes.clear();
    });
  }

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        if (!mounted) return;
        setState(() {
          _minutes = _stopwatch.elapsed.inMinutes % 60;
          _seconds = _stopwatch.elapsed.inSeconds % 60;
          _milliseconds = _stopwatch.elapsedMilliseconds;
        });
        // if (_milliseconds == 1000) {
        //   _milliseconds = 0;
        //   setState(() {});
        // }
      });
    }
  }

  void _takeLap() {
    _laps++;
    _lapTimes.add(_formatTime(_minutes, _seconds, _milliseconds));
    setState(() {});
  }

  void _restartTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.reset();
    }
    setState(() {
      _milliseconds = 0;
      _minutes = 0;
      _seconds = 0;
    });
  }

  void _stopTimer() {
    _stopwatch.reset();
    _stopwatch.stop();
    setState(() {
      _milliseconds = 0;
      _minutes = 0;
      _seconds = 0;
    });
  }

  String _formatTime(int minutos, int segundos, int milisegundos) {
    milisegundos = milisegundos % 1000;

    String minutosStr = (minutos < 10) ? '0$minutos' : minutos.toString();
    String segundosStr = (segundos < 10) ? '0$segundos' : segundos.toString();
    String milisegundosStr =
        (milisegundos < 10) ? '0$milisegundos' : milisegundos.toString();
    return '$minutosStr:$segundosStr:$milisegundosStr';
  }
}
