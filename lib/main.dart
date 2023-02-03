import 'package:flutter/material.dart';

import 'app/app_widget.dart';
import 'app/core/config/env/env.dart';

void main() async{
  await Env.instance.load();
  runApp(const AppWidget());
}
