import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainIndex = StateNotifierProvider<Auth, int>((_) => Auth(0));

class Auth extends StateNotifier<int> {
  Auth(super.state);

  int setIndex(int index) {
    return state = index;
  }

  int defaultIndex() {
    return state = 1;
  }
}
