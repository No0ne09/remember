import 'package:flutter/material.dart';
import 'package:remember/helpers/theme.dart';

class UserHeader extends StatelessWidget {
  const UserHeader(
      {required this.name,
      required this.email,
      required this.connection,
      super.key});

  final String name;
  final String email;
  final String connection;
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: getBackgroundDecoration(context, fit: BoxFit.contain),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            connection,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Opacity(
            opacity: 0.4,
            child: Text(
              email,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
