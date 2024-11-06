import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web/web.dart';

void addAPIkeyWeb() {
  final script = HTMLScriptElement();
  script.src =
      "https://maps.googleapis.com/maps/api/js?key=${dotenv.env["API_KEY"]}";

  document.head!.append(script);
}
