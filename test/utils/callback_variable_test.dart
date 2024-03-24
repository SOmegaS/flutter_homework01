import 'package:flutter_test/flutter_test.dart';
import 'package:homework01/utils/callback_variable.dart';

void main() {
  late CallbackVariable<int> variable;

  setUp(() {
    variable = CallbackVariable(0);
  });

  test(
    "Коллбэк должен отработать",
    () {
      variable.addCallback(() => ++variable.value);
      variable.update();
      expect(variable.value, 1);
    },
  );

  test(
    "Несколько колбэков",
    () {
      variable.addCallback(() => ++variable.value);
      variable.addCallback(() => variable.value += 2);
      variable.update();
      expect(variable.value, 3);
    },
  );

  test(
    "Несколько одинаковых колбэков",
    () {
      variable.addCallback(() => ++variable.value);
      variable.addCallback(() => ++variable.value);
      variable.update();
      expect(variable.value, 2);
    },
  );

  test(
    "Удаление колбэка",
    () {
      int index = variable.addCallback(() => ++variable.value);
      variable.removeCallback(index);
      variable.update();
      expect(variable.value, 0);
    },
  );
}
