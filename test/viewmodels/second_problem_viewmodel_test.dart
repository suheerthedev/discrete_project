import 'package:flutter_test/flutter_test.dart';
import 'package:discrete_project/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('SecondProblemViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
