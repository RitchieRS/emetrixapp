import 'package:vibration/vibration.dart';

Future<void> vibrate() async {
  await Vibration.vibrate(amplitude: 100, duration: 100);
}
