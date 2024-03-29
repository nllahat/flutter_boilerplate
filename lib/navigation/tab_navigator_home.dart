import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/services/activities_service.dart';
import 'package:flutter_boilerplate/services/organizations_service.dart';
import 'package:provider/provider.dart';

import '../router.dart';
import './bottom_navigation.dart';

class TabNavigatorHome extends StatelessWidget {
  TabNavigatorHome({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<OrganizationService>.value(value: OrganizationService()),
        Provider<ActivitiesService>.value(value: ActivitiesService()),
      ],
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
