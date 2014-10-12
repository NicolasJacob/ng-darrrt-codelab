library basics.components.badge_component;

import 'package:angular/angular.dart';



@Injectable()
@Component(
    selector: 'badge',
    templateUrl: 'packages/dart_codelab/components/pirate_badge.html',
    cssUrl: 'packages/dart_codelab/components/pirate_badge.css'
)
class PirateBadge {
  @NgAttr('name')
  String name = '';
}

class BadgeModule extends Module {
  BadgeModule() {
    bind(PirateBadge);
  }
}