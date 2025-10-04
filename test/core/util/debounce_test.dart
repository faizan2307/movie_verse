import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_verse/core/util/debounce.dart';

void main() {
  test('Debouncer triggers only once after delay', () {
    FakeAsync().run((fa) {
      int count = 0;
      final d = Debouncer(const Duration(milliseconds: 300));
      d(() => count++);
      d(() => count++);
      d(() => count++);
      expect(count, 0);
      fa.elapse(const Duration(milliseconds: 299));
      expect(count, 0);
      fa.elapse(const Duration(milliseconds: 1));
      expect(count, 1);
      d.dispose();
    });
  });
}
