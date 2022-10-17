import 'package:flutter/material.dart';

import '/views/login.dart';
import '/views/feed.dart';

const String loginPage = 'login.view';
const String feedPage = 'create_room.view';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => LoginView());
    case feedPage:
      return MaterialPageRoute(builder: (context) => Feed());
    default:
      throw ('Erro!');
  }
}