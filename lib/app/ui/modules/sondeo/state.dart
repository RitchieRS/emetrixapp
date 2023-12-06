import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class SondeoState with _$SondeoState {
  const factory SondeoState({
    // @Default([]) List<SondeosFromStore> data,
    @Default(States.loading) States state,
  }) = _Sondeo;
}

enum States { succes, error, loading }
