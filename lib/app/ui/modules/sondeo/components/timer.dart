import 'dart:async';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTimer extends ConsumerStatefulWidget {
  const MyTimer({super.key, required this.pregunta, required this.times});
  final String pregunta;
  final int times;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyTimerState();
}

class _MyTimerState extends ConsumerState<MyTimer>
    with SingleTickerProviderStateMixin {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _laps = 0;
  final Stopwatch _stopwatch = Stopwatch();
  final List<String> _lapTimes = [];
  AnimationController? _animController;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

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
        if (_laps < widget.times) {
          _takeLap();
        }
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(widget.pregunta, style: t.subtitle),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              _formatTime(_hours, _minutes, _seconds),
              style: const TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _toggle,
                  child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      color: c.primary,
                      progress: _animController!.view),
                ),
                IconButton(
                    onPressed: () => _stopTimer(),
                    icon: const Icon(Icons.stop),
                    color: c.primary),
                IconButton(
                    onPressed: () => _restartTimer(),
                    icon: const Icon(Icons.replay),
                    color: c.primary),
              ],
            ),
            const SizedBox(height: 24.0),
            Text(
              'Vueltas: $_laps',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 24.0),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: _lapTimes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Vuelta ${index + 1}: ${_lapTimes[index]}'),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      if (_stopwatch.isRunning) {
        _pauseTimer();
        _animController!.reverse();
      } else {
        _startTimer();
        _animController!.forward();
      }
    });
  }

  void _startTimer() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        if (!mounted) return;
        setState(() {
          _hours = _stopwatch.elapsed.inHours;
          _minutes = _stopwatch.elapsed.inMinutes % 60;
          _seconds = _stopwatch.elapsed.inSeconds % 60;
        });
      });
    }
  }

  void _takeLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps++;
        _lapTimes.add(_formatTime(_hours, _minutes, _seconds));
      });
    }
  }

  void _restartTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.reset();
    }
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _laps = 0;
      _lapTimes.clear();
    });
  }

  void _stopTimer() {
    _stopwatch.reset();
    _stopwatch.stop();
    _animController!.reverse();

    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _laps = 0;
      _lapTimes.clear();
    });
  }

  void _pauseTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    }
  }

  String _formatTime(int horas, int minutos, int segundos) {
    String horasStr = (horas < 10) ? '0$horas' : horas.toString();
    String minutosStr = (minutos < 10) ? '0$minutos' : minutos.toString();
    String segundosStr = (segundos < 10) ? '0$segundos' : segundos.toString();
    return '$horasStr:$minutosStr:$segundosStr';
  }
}
