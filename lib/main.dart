import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/helpers/theme.dart';

/*For web purposes only. If you want to compile app for android this needs to be commented out*/
//import 'package:remember/helpers/dev_web_api_parsing.dart';

import 'package:remember/screens/auth_screen.dart';
import 'package:remember/screens/content_screen.dart';
import 'helpers/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: '.env');
  /*For web purposes only. If you want to compile app for android this needs to be commented out*/
  //if (kIsWeb) addAPIkeyWeb();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {
      FlutterError.onError = (details) async {
        if (!kIsWeb) {
          await FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        }
        String error = "${details.exception} \n ${details.stack}";

        String version = await getAppVersion();

        try {
          await http.post(
            Uri.parse(autoReportUrl),
            body: {
              'entry.1191287436': error,
              'entry.1479404169': version,
              'entry.517717971': kIsWeb.toString(),
            },
          );
        } catch (_) {}
      };
      if (!kIsWeb) {
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      }
      runApp(
        const ProviderScope(
          child: App(),
        ),
      );
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      title: appName,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl'),
      ],
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const AuthScreen();
          }
          return const ContentScreen();
        },
      ),
    );
  }
}
