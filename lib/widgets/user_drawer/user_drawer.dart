import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember/helpers/constants.dart';
import 'package:remember/helpers/functions.dart';
import 'package:remember/widgets/user_drawer/drawer_option.dart';
import 'package:remember/widgets/password_reset/in_app_reset_popup.dart';

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
      width: MediaQuery.of(context).size.width * 0.75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                decoration: backgroundDecoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_authInstance.currentUser!.displayName}',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${_authInstance.currentUser!.email}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              DrawerOption(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => InAppResetPopup(
                      ref: ref,
                    ),
                  );
                },
                text: "Zresetuj hasło",
                icon: Icons.password,
              ),
              DrawerOption(
                onTap: () {
                  logOut(ref);
                },
                text: "Wyloguj się",
                icon: Icons.exit_to_app_rounded,
              ),
              const Spacer(),
              Text(
                textAlign: TextAlign.center,
                "Re(me)mber \n v$appVersion",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
