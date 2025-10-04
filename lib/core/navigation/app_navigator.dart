import '../../data/router/app_router.dart';

abstract class AppNavigator {
  void go(String location);
  void push(String location);
}

class GoRouterNavigator implements AppNavigator {
  GoRouterNavigator();

  @override
  void go(String location) => router.go(location);

  @override
  void push(String location) => router.push(location);
}
