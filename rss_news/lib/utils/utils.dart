import 'package:url_launcher/url_launcher.dart';

class URLHandler {
  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      final bool launched =
          await launch(url, forceSafariVC: false, universalLinksOnly: true);
      if (!launched) {
        await launch(url, forceSafariVC: false);
      }
    }
  }
}
