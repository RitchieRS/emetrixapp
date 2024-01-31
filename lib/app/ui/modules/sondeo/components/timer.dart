import 'dart:async';
import 'dart:isolate';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class MyTimer extends ConsumerStatefulWidget {
  const MyTimer({
    super.key,
    required this.pregunta,
    required this.times,
    this.mandatory = false, 
    required this.preguntawid,
  });
  final String pregunta;
  final int times;
  final bool mandatory;
  final Preguntas preguntawid;

  

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyTimerState();
}

class _MyTimerState extends ConsumerState<MyTimer>
    with SingleTickerProviderStateMixin {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _milliseconds = 0;
  // int _laps = 0;
  //final Stopwatch _stopwatch = Stopwatch();
  var _lapTimes;
  var _stopwatch;
  Timer? timerlocal;


  @override
  void dispose() {
    //_stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    final size = MediaQuery.of(context).size;
    _stopwatch = ref.watch(stopwatchProviderFamily(int.parse(widget.preguntawid.id ?? '0')));
    _lapTimes = ref.watch(stringListProvider(int.parse(widget.preguntawid.id ?? '0')));
    if (_stopwatch.isRunning() ) {
      _startTimer();
    }
   
    return GestureDetector(
      onTap: () => _handleLaps(),
      // onTap: () {
      //   _handleLaps();
      //   debugPrint('Tap Laps: $_laps');
      //   debugPrint('Laps list: $_lapTimes');
      // },
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
              _formatTime(_hours,_minutes, _seconds, _milliseconds),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _lapTimes.length,
              itemBuilder: (BuildContext context, int index) {
                
                return ListTile(
                  title: Text(_lapTimes[index]),
                  onTap: () => _resetLaps(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _handleLaps() {
    
    if (!_stopwatch.isRunning()) {
      _resetLaps();
      _startTimer();
      return;
    }
    if (_stopwatch.isRunning() && (_lapTimes.length + 1 )== widget.times) {
      
      _stopTimer();
      //_stopwatch.awaitIso();
      return;
    }
     else if (_stopwatch.isRunning() && _lapTimes.length < widget.times) {
      _takeLap();
      _restartTimer();
    }
    logger.d("Timer Stop ${_lapTimes.length} ${widget.times}");
    
  }

  void _resetLaps() {
    
    setState(() {
      // _laps = 0;
      _restartTimer();
      _lapTimes.clear();
      
    });
  }

  void _startTimer() {
    SystemSound.play(SystemSoundType.click);
    if (!_stopwatch.isRunning()) {
      _stopwatch.start();
      timerlocal = Timer.periodic(const Duration(seconds: 0), (timer) {
        if (!mounted) return;
        setState(() {
          _hours    = _stopwatch.hours();
          _minutes = _stopwatch.minutes();
          _seconds = _stopwatch.seconds();
          _milliseconds = _stopwatch.milliseconds();
        });
      });
    }
    else
    {
      timerlocal = Timer.periodic(const Duration(milliseconds: 0), (timer) {
        if (!mounted) return;
        setState(() {
          _hours    = _stopwatch.hours();
          _minutes = _stopwatch.minutes();
          _seconds = _stopwatch.seconds();
          _milliseconds = _stopwatch.milliseconds();
        });
      });
    }
  }

  void _takeLap() {
    if (_stopwatch.isRunning()) {
      _stopwatch.reset();
    }
    // _laps++;
    logger.d("Timer takelap");
    _lapTimes.add(_formatTime(_hours,_minutes, _seconds, _milliseconds));
    setState(() {});
  }

  void _restartTimer() {
    logger.d("Timer reStart");
    if (_stopwatch.isRunning()) {
      _stopwatch.reset();
    }
    setState(() {
      _hours    = 0;
      _milliseconds = 0;
      _minutes = 0;
      _seconds = 0;
    });
  }

  void _stopTimer() {
    logger.d("Timer Stop");
    //_stopwatch.reset();
    setState(() {
    _lapTimes.add(_formatTime(_hours,_minutes, _seconds, _milliseconds));
    _stopwatch.stop();
    timerlocal!.cancel();
      _hours    = 0;
      _milliseconds = 0;
      _minutes = 0;
      _seconds = 0;
    });
  }

  String _formatTime(int horas,int minutos, int segundos, int milisegundos) {
    milisegundos = milisegundos % 1000;
    String horasStr = (horas < 10) ? '0$horas' : horas.toString();
    String minutosStr = (minutos < 10) ? '0$minutos' : minutos.toString();
    String segundosStr = (segundos < 10) ? '0$segundos' : segundos.toString();
    String milisegundosStr =
        (milisegundos < 10) ? '0$milisegundos' : milisegundos.toString();
    return '$horasStr:$minutosStr:$segundosStr';
  }
}
