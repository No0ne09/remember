import 'package:remember/helpers/constants.dart';
import 'package:web/web.dart';

void addAPIkeyWeb() {
  final script = HTMLScriptElement();
  script.src = "https://maps.googleapis.com/maps/api/js?key=$apiKey";

  document.head!.append(script);
}
