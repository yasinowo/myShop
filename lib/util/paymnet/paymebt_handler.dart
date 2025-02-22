import 'dart:async';

import 'package:aplle_shop_pj/data/datasourse/repository/carditem_repository.dart';
import 'package:aplle_shop_pj/util/extentions.dart';
import 'package:aplle_shop_pj/util/url_handler.dart';
import 'package:app_links/app_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  //must be Future
  Future<bool> initPayment(int finalPrice);
  Future sendRequestPayment();
  Future<bool> verifyPayment();
}

class ZarinpalPayment extends PaymentHandler {
  final ICardItemRepository cardItemRepository;

  //true constractor indection
  //UrlHandler urlLuncher = UrlLuncher(); to UrlHandler urlLuncher; and in di = locator.registerSingleton<UrlHandler>(UrlLuncher());
  PaymentRequest paymentRequest = PaymentRequest();
  UrlHandler urlLuncher;

  ZarinpalPayment(
    this.urlLuncher,
    this.cardItemRepository,
  );

  String? authority;
  String? status;
  @override
  Future<bool> initPayment(int finalPrice) async {
    Completer<bool> completer = Completer<bool>();

    paymentRequest.setIsSandBox(true);
    paymentRequest.setAmount(finalPrice);
    paymentRequest.setDescription('this is a test');
    paymentRequest.setMerchantID('4d3734c2-af46-40d7-be39-a868668e9604');
    paymentRequest.setCallbackURL('returne://appleshop');

    final appLinks = AppLinks(); // AppLinks is singleton
    appLinks.uriLinkStream.listen((uri) async {
      var defultUri = uri.toString();
      if (defultUri.contains('Authority')) {
        authority = extractValueFromQuery2(defultUri, 'Authority');
        status = extractValueFromQuery2(defultUri, 'Status');
        print('Authority: $authority, Status: $status');

        // Call verifyPayment and handle the result
        bool result = await verifyPayment();
        completer.complete(result); // Complete with true or false
      }
    });

    return completer.future; // Return the future to indicate result
  }

  @override
  Future sendRequestPayment() async {
    ZarinPal().startPayment(
      paymentRequest,
      (
        int? status,
        String? paymentGatewayUri,
        data,
      ) {
        if (status == 100) {
          urlLuncher.lunchUrl(paymentGatewayUri);
        }
      },
    );
  }

  @override
  Future<bool> verifyPayment() async {
    Completer<bool> completer = Completer<bool>();

    ZarinPal().verificationPayment(
      status!,
      authority!,
      paymentRequest,
      (isPaymentSuccess, refID, paymentRequest, data) {
        if (isPaymentSuccess) {
          print('------------------');
          print('isPaymentSuccess +$refID');
          completer.complete(true); // مقدار موفقیت پرداخت را تکمیل کنید
          // cardItemBlock.add(CardItemRemoveALLEvent());
        } else {
          print('!!!PaymentError + $refID');
          completer.complete(false); // مقدار خطا را تکمیل کنید
          // cardItemBlock.add(CardItemFaildRequestEvent());
        }
      },
    );

    return completer.future;
  }
}
