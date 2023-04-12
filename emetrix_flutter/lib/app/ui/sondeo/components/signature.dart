import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Signature extends ConsumerStatefulWidget {
  const Signature({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignatureState();
}

class _SignatureState extends ConsumerState<Signature> {
  // HandSignatureControl control = HandSignatureControl(
  //   threshold: 0.01,
  //   smoothRatio: 0.65,
  //   velocityRange: 2.0,
  // );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: Center(child: Text('Firma.', style: t.medium)),
            // child: HandSignature(
            //   control: control,
            //   type: SignatureDrawType.shape,
            // ),
          )),
    );
    // CustomPaint(
    //   painter: DebugSignaturePainterCP(
    //     control: control,
    //     cp: false,
    //     cpStart: false,
    //     cpEnd: false,
    //   ),
    // ),
  }
}
