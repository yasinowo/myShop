import 'package:aplle_shop_pj/constants/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
          child: Column(
        children: [
          Stack(alignment: AlignmentDirectional.topStart, children: [
            Padding(
              padding: EdgeInsets.only(top: 26.h),
              child: InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Icon(
                  Icons.menu,
                  size: 35,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                child: Container(
                  width: 300.w,
                  height: 40.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Image.asset('assets/images/icon_apple_blue.png'),
                        const Expanded(
                          child: Text('حساب کاربری',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: CustomColor.blue,
                                  fontFamily: 'sb',
                                  fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                )),
          ]),

          const Text(
            'یاسین عزیزی',
            style:
                TextStyle(color: Colors.black, fontFamily: 'sb', fontSize: 20),
          ),
          const Text('09025008981',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'sm', fontSize: 16)),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 40.w),
          //   child: Directionality(
          //     textDirection: TextDirection.rtl,
          //     child: Wrap(
          //       runSpacing: 20,
          //       spacing: 40,
          //       children: [
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //         // horizontalyListORitmChip(),
          //       ],
          //     ),
          //   ),
          // ),
          const Spacer(),
          const Text(
            'my shop',
            style: TextStyle(
                fontFamily: 'sb', color: CustomColor.grey, fontSize: 12),
          ),
          const Text(
            'v-1.0.00',
            style: TextStyle(
                fontFamily: 'sb', color: CustomColor.grey, fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InkWell(
                child: Text(
                  'telegram : ',
                  style: TextStyle(
                      fontFamily: 'sb', color: CustomColor.grey, fontSize: 12),
                ),
              ),
              InkWell(
                onTap: () {
                  Uri uri = Uri.parse('https://t.me/yasinid');
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                child: const Text(
                  '@yasinid',
                  style: TextStyle(
                      fontFamily: 'sb', color: Colors.blue, fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      )),
    );
  }

  horizontalyListORitmChip() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: Colors.amber,
                shadows: const [
                  BoxShadow(
                      color: Colors.amber,
                      blurRadius: 25,
                      offset: Offset(0, 15),
                      spreadRadius: -15)
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            const Icon(
              Icons.mouse,
              size: 35,
              color: Colors.white,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'همه',
          style: TextStyle(fontFamily: 'SB', fontSize: 12),
        ),
      ],
    );
  }
}
