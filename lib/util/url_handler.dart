import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  lunchUrl(String? uri);
}

class UrlLuncher extends UrlHandler {
  @override
  lunchUrl(String? uri) {
    launchUrl(Uri.parse(uri!), mode: LaunchMode.externalApplication);
  }
}
