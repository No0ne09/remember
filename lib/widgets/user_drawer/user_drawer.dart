import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/strings.dart';
import 'package:remember/widgets/user_drawer/drawer_option.dart';
import 'package:remember/screens/in_app_password_reset.dart';
import 'package:remember/widgets/user_drawer/user_header.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDrawer extends ConsumerStatefulWidget {
  const UserDrawer({super.key});

  @override
  ConsumerState<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends ConsumerState<UserDrawer> {
  final _authInstance = FirebaseAuth.instance;
  String _appVersion = '';
  String _connection = offline;

  Future<void> _getVersion() async {
    final version = await appVersion;
    setState(() {
      _appVersion = version;
    });
  }

  void _getConnection() async {
    final res = await checkConnection();
    setState(() {
      _connection = res ? online : offline;
    });
  }

  @override
  void initState() {
    super.initState();
    _getVersion();
    _getConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserHeader(
                  name: '${_authInstance.currentUser!.displayName}',
                  email: '${_authInstance.currentUser!.email}',
                  connection: _connection),
              DrawerOption(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InAppPasswordReset(),
                    ),
                  );
                },
                text: resetPassword,
                icon: Icons.password,
              ),
              DrawerOption(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(reportBugUrl),
                  );
                },
                text: reportBug,
                icon: Icons.bug_report,
              ),
              DrawerOption(
                onTap: () async {
                  await launchUrl(
                    Uri.parse(sendMailUrl),
                  );
                },
                text: support,
                icon: Icons.help_center,
              ),
              const Spacer(),
              DrawerOption(
                onTap: () {
                  _authInstance.signOut();
                },
                text: logOut,
                icon: Icons.exit_to_app_rounded,
              ),
              Text(
                textAlign: TextAlign.center,
                "$appName \n v$_appVersion",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
