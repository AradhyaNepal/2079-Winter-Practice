import 'package:flutter_riverpod/flutter_riverpod.dart';


final counterProvider=StateProvider((ref) => 1);
final stringCounterProvider=Provider((ref) {
  return ref.watch(counterProvider).toString();
});