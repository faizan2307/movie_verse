import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_verse/core/constants/app_strings.dart';
import 'package:movie_verse/core/deep_link/deep_link_handler.dart';
import 'package:movie_verse/data/router/app_router.dart';

void main() {
  group('DeepLinkHandler.handle', () {
    late DeepLinkHandler handler;

    setUp(() {
      handler = DeepLinkHandler();
    });

    tearDown(() async {
      await handler.dispose();
    });

    String _currentPath() {
      final value = router.routeInformationProvider.value;
      try {
        // Newer Flutter exposes uri
        return value.uri.path;
      } catch (_) {
        final loc = value.location;
        if (loc != null) return Uri.parse(loc).path;
        return '';
      }
    }

    testWidgets('navigates for host form: visionmovies://movie/123', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      expect(_currentPath(), '/splash');
      final uri = Uri.parse('${AppStrings.deepLinkScheme}://${AppStrings.deepLinkHost}/123');
      handler.handle(uri);
      await tester.pumpAndSettle();
      expect(_currentPath(), '/movie/123');
    });

    testWidgets('navigates for extra segments: visionmovies://movie/456/anything', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      expect(_currentPath(), '/splash');
      final uri = Uri.parse('${AppStrings.deepLinkScheme}://${AppStrings.deepLinkHost}/456/anything');
      handler.handle(uri);
      await tester.pumpAndSettle();
      expect(_currentPath(), '/movie/456');
    });

    testWidgets('ignores wrong scheme', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      expect(_currentPath(), '/splash');
      final uri = Uri.parse('wrongscheme://${AppStrings.deepLinkHost}/123');
      handler.handle(uri);
      await tester.pumpAndSettle();
      expect(_currentPath(), '/splash');
    });

    testWidgets('ignores wrong host', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      expect(_currentPath(), '/splash');
      final uri = Uri.parse('${AppStrings.deepLinkScheme}://wronghost/123');
      handler.handle(uri);
      await tester.pumpAndSettle();
      expect(_currentPath(), '/splash');
    });

    testWidgets('ignores invalid id', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      expect(_currentPath(), '/splash');
      final uri = Uri.parse('${AppStrings.deepLinkScheme}://${AppStrings.deepLinkHost}/bad');
      handler.handle(uri);
      await tester.pumpAndSettle();
      expect(_currentPath(), '/splash');
    });

    testWidgets('accepts id=0', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      expect(_currentPath(), '/splash');
      final uri = Uri.parse('${AppStrings.deepLinkScheme}://${AppStrings.deepLinkHost}/0');
      handler.handle(uri);
      await tester.pumpAndSettle();
      expect(_currentPath(), '/movie/0');
    });

    testWidgets('handles query/fragment but still navigates', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      expect(_currentPath(), '/splash');
      final uri = Uri.parse('${AppStrings.deepLinkScheme}://${AppStrings.deepLinkHost}/123?x=1#f');
      handler.handle(uri);
      await tester.pumpAndSettle();
      expect(_currentPath(), '/movie/123');
    });
  });
}
