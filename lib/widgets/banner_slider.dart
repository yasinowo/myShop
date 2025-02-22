import 'package:aplle_shop_pj/constants/color.dart';
import 'package:aplle_shop_pj/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// ignore: library_prefixes
import 'package:aplle_shop_pj/data/model/banner.dart' as myBanner;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerSlider extends StatefulWidget {
  BannerSlider({super.key, required this.bannerList});
  List<myBanner.Banner> bannerList;
  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(viewportFraction: 0.9);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                child: CachedImage(
                  urlImage: widget.bannerList[index].thumbnail,
                  fontSize: 50,
                  radios: 12,
                ),
              );
            },
            itemCount: widget.bannerList.length,
          ),
        ),
        Positioned(
          bottom: 5.h,
          child: SmoothPageIndicator(
            controller: controller,
            count: widget.bannerList.length,
            effect: ExpandingDotsEffect(
                expansionFactor: 4,
                dotColor: Colors.white,
                dotWidth: 6.w,
                dotHeight: 6.h,
                activeDotColor: CustomColor.blue),
          ),
        )
      ],
    );
  }
}
