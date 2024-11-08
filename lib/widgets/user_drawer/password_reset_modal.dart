import 'package:flutter/material.dart';
import 'package:remember/widgets/modal_base.dart';

class PasswordResetModal extends StatefulWidget {
  const PasswordResetModal({super.key});

  @override
  State<PasswordResetModal> createState() => _PasswordResetModalState();
}

class _PasswordResetModalState extends State<PasswordResetModal> {
  @override
  Widget build(BuildContext context) {
    return const ModalBase(child: Placeholder());
  }
}
