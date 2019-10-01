import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/providers/auth.dart';
import 'package:flutter_boilerplate/providers/records.dart';
import 'package:provider/provider.dart';

import '../router.dart';
import './bottom_navigation.dart';

class TabNavigatorHome extends StatelessWidget {
  TabNavigatorHome({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<Auth, Records>(
      builder: (ctx, auth, previousRecords) => Records(
        previousRecords == null ? [] : previousRecords.items,
      ),
      child: Navigator(
          key: navigatorKey,
          initialRoute: '/home',
          onGenerateRoute: Router.generateRouteHome,
          onUnknownRoute: (settings) => MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
              )),
    );
  }
}