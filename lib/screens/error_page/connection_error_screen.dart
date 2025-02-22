import 'package:aplle_shop_pj/data/bloc/home/home_bloc.dart';
import 'package:aplle_shop_pj/data/bloc/home/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background Image
          Image.asset(
            'assets/images/10_Connection-Lost_2x.png', // مسیر فایل SVG2_No Connection@2x.svg
            fit: BoxFit.cover,
            height: double.infinity.h,
            width: double.infinity.w,
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title Text
              const Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  '!!!خطا',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'sb'),
                ),
              ),
              SizedBox(height: 0.h),
              // Description Text
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  "خطا در برقرای ارتباط \nاینترنت خود را چک کنید",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              // Retry Button
              ElevatedButton(
                onPressed: () {
                  // Action for retry
                  context.read<HomeBloc>().add(HomeGetInitializeData());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 15.h,
                  ),
                ),
                child: const Text(
                  "RETRY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
