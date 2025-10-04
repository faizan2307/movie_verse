import 'package:flutter_test/flutter_test.dart';
import 'package:movie_verse/core/util/images_urls.dart';

void main() {
  group('posterUrl', () {
    test('returns empty for null', () {
      expect(posterUrl(null), '');
    });
    test('returns empty for empty string', () {
      expect(posterUrl(''), '');
    });
    test('builds url with default size', () {
      final u = posterUrl('/abc.jpg');
      expect(u, contains('/w342/abc.jpg'));
    });
    test('builds url with custom size', () {
      final u = posterUrl('/abc.jpg', size: 'w780');
      expect(u, contains('/w780/abc.jpg'));
    });
  });
}
