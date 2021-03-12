import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turbo_express/res/style.dart';

class BackgroundLayer extends StatelessWidget {
  final Size size;
  final PageController pageController;
  final Function(int) onPageChanged;

  BackgroundLayer({
    @required this.size,
    @required this.pageController,
    @required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: size.height,
        width: size.width,
        child: PageView(
          physics: ClampingScrollPhysics(),
          controller: pageController,
          onPageChanged: (int page) => onPageChanged(page),
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Image.asset(
                    'assets/images/image1.png',
                    colorBlendMode: BlendMode.multiply,
                    color: Colors.black.withOpacity(0.3),
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 64.h),
                    Image.asset(
                      'assets/icons/icon.png',
                      height: 256,
                      width: 256,
                    ),
                    Text(
                      'text1',
                      style: defaultStyle.copyWith(color: Colors.white, fontSize: 48.ssp),
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(height: 24.h),
                    Text(
                      'text2',
                      style: basicStyle4.copyWith(color: Colors.white, fontSize: 32.ssp),
                      textAlign: TextAlign.center,
                    ).tr()
                  ],
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Image.asset(
                    'assets/images/intro_2.png',
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.multiply,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 64.h),
                    Image.asset(
                      'assets/icons/icon.png',
                      height: 256,
                      width: 256,
                    ),
                    Text(
                      'text3',
                      style: basicStyle5.copyWith(color: Colors.white, fontSize: 48.ssp),
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(height: 24.h),
                    Text(
                      'text4',
                      style: basicStyle4.copyWith(color: Colors.white, fontSize: 32.ssp),
                      textAlign: TextAlign.center,
                    ).tr()
                  ],
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Image.asset(
                    'assets/images/intro_3.png',
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.multiply,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 64.h),
                    Image.asset(
                      'assets/icons/icon.png',
                      height: 256,
                      width: 256,
                    ),
                    Text(
                      'text5',
                      style: basicStyle5.copyWith(color: Colors.white, fontSize: 48.ssp),
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(height: 24.h),
                    Text(
                      'text6',
                      style: basicStyle4.copyWith(color: Colors.white, fontSize: 32.ssp),
                      textAlign: TextAlign.center,
                    ).tr(),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}
