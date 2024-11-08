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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cześć, ${_authInstance.currentUser!.displayName}! 👋',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        _authInstance.currentUser!.email!,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () async {},
                title: const Text("Zresetuj hasło"),
                leading: const Icon(Icons.password),
              ),
              ListTile(
                onTap: () {
                  ref.read(indexProvider.notifier).state = 0;
                  _authInstance.signOut();
                },
                leading: const Icon(Icons.exit_to_app_rounded),
                title: const Text("Wyloguj się"),
              ),
              const Spacer(),
              const Text("Re(me)mber"),
              Text('v$appVersion'),
            ],
          ),
        ),
      ),
    );
  }
}
