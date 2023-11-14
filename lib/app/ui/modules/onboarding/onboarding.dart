import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/ui/modules/onboarding/utils.dart';
import 'package:emetrix_flutter/app/ui/modules/onboarding/select_theme.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  int currentPage = 0;
  bool showStart = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (!showStart && (currentPage + 1) >= (onboardingPages.length - 0.5)) {
        setState(() {
          showStart = true;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appbar = AppBar(
      backgroundColor: c.surface,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: c.surface, statusBarIconBrightness: Brightness.dark),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appbar,
      body: FadeIn(
        delay: const Duration(milliseconds: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.05),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        if (currentPage + 1 == onboardingPages.length) {
                          return;
                        }
                        controller.animateToPage(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 500),
                            onboardingPages.length);
                      },
                      child: Text('Saltar', style: t.mediumBold))),
            ),
            SizedBox(
              height: size.height * 0.6,
              width: size.width,
              child: PageView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) => onboardingPages[index],
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.04),
              child: SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.3,
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(width: size.width * 0.05),
                    shrinkWrap: true,
                    itemCount: onboardingPages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: size.height * 0.008,
                        width: size.height * 0.008,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index
                                ? c.primary500
                                : c.primary500.withOpacity(0.2)),
                      );
                    }),
              ),
            ),
            // currentPage + 1 == pages.length
            showStart
                ? ButonDimentions(
                    background: c.primary500,
                    title: 'Comenzar',
                    style: t.mediumLight,
                    onTap: () => Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, animation, __) => FadeTransition(
                                  opacity: animation,
                                  child: const SelectThemePage(),
                                ))),
                    width: size.width * 0.85,
                    height: size.height * 0.052)
                : SizedBox(height: size.height * 0.052)
          ],
        ),
      ),
    );
  }
}
