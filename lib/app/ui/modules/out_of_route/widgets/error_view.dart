import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/modules/out_of_route/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorView extends ConsumerWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final state = ref.watch(outORControllerProvider);
    final size = MediaQuery.of(context).size;

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
          child: SvgPicture.asset(
            AppAssets.error,
            height: size.height * 0.15,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.04),
          child: Text(
            state.homeData?.idError.toString() ??
                'Hubo un problema con la descarga de tiendas. Inténtalo de nuevo.',
            style: isDark ? t.mediumLight : t.mediumDark,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
