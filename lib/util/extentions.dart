import 'package:flutter/material.dart';

extension ColorParsing on String? {
  Color parseColorM() {
    String categoryColor = 'ff$this';
    var hexColor = int.parse(categoryColor, radix: 16);
    return Color(hexColor);
  }
}

// price_formatter.dart
extension PriceFormatter on String {
  String toPriceWithCommas() {
    if (isEmpty) return "Invalid Input";

    try {
      final number = int.parse(this); // Convert string to integer
      final buffer = StringBuffer();
      String reversed = number.toString().split('').reversed.join();

      for (int i = 0; i < reversed.length; i++) {
        buffer.write(reversed[i]);
        if ((i + 1) % 3 == 0 && i != reversed.length - 1) {
          buffer.write(',');
        }
      }

      return buffer.toString().split('').reversed.join();
    } catch (e) {
      return "Invalid Input";
    }
  }
}

String? extractValueFromQuery2(String url, String key) {
  // پیدا کردن موقعیت علامت سوال که شروع قسمت پرس و جو را نشان می دهد
  int queryStartIndex = url.indexOf('?');

  // اگر علامت سوال پیدا نشد، یعنی URL پارامتر ندارد
  if (queryStartIndex == -1) {
    return null;
  }

  // استخراج قسمت پرس و جو از URL
  String query = url.substring(queryStartIndex + 1);

  // تقسیم پرس و جو به جفت های کلید-مقدار
  List<String> pairs = query.split('&');

  // جستجو برای جفت کلید-مقدار مورد نظر
  for (String pair in pairs) {
    List<String> keyValue = pair.split('=');

    // اگر جفت کلید-مقدار شامل دو بخش باشد (کلید و مقدار)
    if (keyValue.length == 2) {
      String currentKey = keyValue[0];
      String value = keyValue[1];

      // اگر کلید فعلی با کلید مورد نظر مطابقت داشت
      if (currentKey == key) {
        // مقدار را از حالت URL-encoded به حالت قابل خواندن تبدیل و برگردان
        return Uri.decodeComponent(value);
      }
    }
  }

  // اگر کلید پیدا نشد، null برگردان
  return null;
}
  //main
//  //expertflutter://shop?authority=13232432342344342&status=ok
  // String? extractValueFromQuery(String key) {
  //   // Remove everything before the question mark
  //   int queryStartIndex = this!.indexOf('?');
  //   if (queryStartIndex == -1) return null;

  //   String query = this!.substring(queryStartIndex + 1);

  //   // Split the query into key-value pairs
  //   List<String> pairs = query.split('&');

  //   // Find the key-value pair that matches the given key
  //   for (String pair in pairs) {
  //     List<String> keyValue = pair.split('=');
  //     if (keyValue.length == 2) {
  //       String currentKey = keyValue[0];
  //       String value = keyValue[1];

  //       if (currentKey == key) {
  //         // Decode the URL-encoded value
  //         return Uri.decodeComponent(value);
  //       }
  //     }
  //   }

  //   return null;
  // }