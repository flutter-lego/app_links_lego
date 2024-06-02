import 'package:app_links/app_links.dart';
import 'package:easy_event_bus/easy_event_bus.dart';
import 'package:flutter/material.dart';

import '../../../../../../main.dart';

@ReadyBeforeRunApp()
Future<void> readyForAppLinksLego() async {
  final _appLinks = AppLinks(); // AppLinks is singleton

  _appLinks.uriLinkStream.listen((uri) {
    print('receive_app_links_uri: $uri');
    EasyEventBus.fire('receive_app_links_uri', uri);
  });


}
