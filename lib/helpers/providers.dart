import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = StateProvider<int>(
  (ref) => 0,
);

final memoryOrderProvider = StateProvider<bool>(
  (ref) => true,
);
final memoryOverlayProvider = StateProvider<bool>(
  (ref) => false,
);
