// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.



import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:dart_codelab/pirate_module.dart';
import 'package:dart_codelab/components/pirate_badge.dart';



main() {
   applicationFactory()
   ..addModule(new BadgeModule())
   ..addModule(new PirateModule())
   ..rootContextType(BadgeController)
   ..run();
}