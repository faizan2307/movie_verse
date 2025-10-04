import 'package:flutter_test/flutter_test.dart';
import 'package:movie_verse/core/util/deep_link_utils.dart';

void main() {
  group('DeepLinkUtils', () {
    test('createMovieDeepLink builds scheme://host/id', () {
      expect(DeepLinkUtils.createMovieDeepLink(123), 'visionmovies://movie/123');
    });

    test('createShareMessage contains text and link', () {
      final s = DeepLinkUtils.createShareMessage(789);
      expect(s.split('\n'), hasLength(2));
      expect(s, contains('visionmovies://movie/789'));
    });

    test('isValidDeepLink true for simple link', () {
      expect(DeepLinkUtils.isValidDeepLink('visionmovies://movie/42'), isTrue);
    });

    test('isValidDeepLink false for wrong scheme/host/query/fragment', () {
      expect(DeepLinkUtils.isValidDeepLink('bad://movie/1'), isFalse);
      expect(DeepLinkUtils.isValidDeepLink('visionmovies://wrong/1'), isFalse);
      expect(DeepLinkUtils.isValidDeepLink('visionmovies://movie/1?x=1'), isFalse);
      expect(DeepLinkUtils.isValidDeepLink('visionmovies://movie/1#f'), isFalse);
    });

    test('parseMovieDeepLink returns id or null', () {
      expect(DeepLinkUtils.parseMovieDeepLink('visionmovies://movie/123'), 123);
      expect(DeepLinkUtils.parseMovieDeepLink('visionmovies://movie/bad'), isNull);
      expect(DeepLinkUtils.parseMovieDeepLink('bad://movie/1'), isNull);
    });
  });
}
