import 'package:flutter/material.dart';
import '../../../../../main.dart';
import 'app_links_lego/_.dart';

Future<void> readyBeforeRunApp() async {
  if (_done) return;
  _done = true;
  await Future.wait([
    readyForAppLinksLego(),
  ]);

}

bool _done = false;
