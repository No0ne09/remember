import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/helpers/providers.dart';

class UserDrawer extends ConsumerStatefulWidget {
  const UserDrawer({super.key});

  @override
  ConsumerState<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends ConsumerState<UserDrawer> {
  final _authInstance = FirebaseAuth.instance;

  String appVersion = '';
  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  void _getVersion() async {
    final version = await getAppVersion();
    setState(() {
      appVersion = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                    'Cześć, ${_authInstance.currentUser!.displayName}! 👋'),
              ),
            ),
            ListTile(
              onTap: () async {},
              title: const Text("Zresetuj hasło"),
              leading: const Icon(Icons.password),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                ref.read(indexProvider.notifier).state = 0;
                _authInstance.signOut();
              },
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text("Wyloguj się"),
            ),
            Text(appVersion),
          ],
        ),
      ),
    );
  }
}
