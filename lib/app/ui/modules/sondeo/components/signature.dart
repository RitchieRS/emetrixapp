import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_signature/signature.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Signature extends ConsumerStatefulWidget {
  const Signature({super.key, required this.pregunta});
  final String pregunta;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignatureState();
}

class _SignatureState extends ConsumerState<Signature>
    with AutomaticKeepAliveClientMixin {
  final control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.6,
      width: size.width,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Text(widget.pregunta, style: t.subtitle),
          ),
          SizedBox(height: size.height * 0.02),
          Center(
            child: Container(
              height: size.height * 0.55,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: c.primary),
                  color: c.background,
                  borderRadius: BorderRadius.circular(10)),
              child: HandSignature(
                control: control,
                color: Colors.blueGrey,
                width: 1.0,
                maxWidth: 10.0,
                type: SignatureDrawType.shape,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: _clear,
                  icon: Icon(Icons.delete, color: c.primary)),
              IconButton(
                  onPressed: () => _capturePng(size),
                  icon: Icon(Icons.save_alt, color: c.primary)),
            ],
          ),
        ],
      ),
    );
  }

  Future _capturePng(Size size) async {
    MesagessService.showSuccess(
        context: context,
        message: 'Firma Guardada',
        marginBottom: EdgeInsets.only(bottom: size.height * 0.77));

    // final image = control.toImage();
    //Make something with the image
  }

  void _clear() {
    control.clear();
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
