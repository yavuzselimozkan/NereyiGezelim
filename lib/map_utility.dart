import 'package:url_launcher/url_launcher.dart';

class MapUtility
{
  Future<void> openMap(String locationName) async
  {
    final Uri googleUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(locationName)}');

    if(await canLaunchUrl(googleUri))
      {
        await launchUrl(googleUri);
      }
    else
      {
        throw "Can not to open map.";
      }
  }
}