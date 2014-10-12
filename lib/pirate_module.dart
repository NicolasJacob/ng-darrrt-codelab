library basics.pirate_module;

import 'package:angular/angular.dart';
import 'package:dart_codelab/model/name.dart';
import 'dart:math' show Random;
import 'dart:async' show Future;
import 'dart:html';
import 'dart:convert';
// ...
const List names = const [
   'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
   'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];

const List appellations = const [
   'Jackal', 'King', 'Red', 'Stalwart', 'Axe',
   'Young', 'Brave', 'Eager', 'Wily', 'Zesty'];

String _oneRandom(List<String> list) =>
      list[new Random().nextInt(list.length)];


class PirateModule extends Module {
  PirateModule() {
    bind(NamesService);
    bind(CapitalizeFilter);
    bind(BadgeController);
  }
}

@Injectable()
class BadgeController {

  NamesService ns;

  PirateName pn = new PirateName();

  String get pirateName => pn.firstName.isEmpty ? '' :
    '${pn.firstName} the ${pn.appellation}';

  BadgeController(this.ns);

  String _name = '';

  get name => _name;

  set name(newName) {
    _name = newName;
    ns.randomAppellation().then((appellation) {
      pn..firstName = newName
        ..appellation = appellation;
    });
  }

  bool get inputIsNotEmpty => name.trim().isNotEmpty;
  String get label => inputIsNotEmpty ? "Arrr! Write yer name!" :
    "Aye! Gimme a name!";

  Future generateName() => ns.randomName().then((aName) {
    name = aName;
  });
}

@Formatter(name: 'capitalize')
class CapitalizeFilter {
  call(String name) {
    if (name == null || name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1);
  }
}

@Injectable()
class NamesService {
  static Random rand = new Random();
  final HttpBackend _http;
  List<String> names;
  List<String> appellations;
  // Fails if _http is of Http !! ??
  NamesService(this._http);

  Future _loadData() {
    if (names != null) return new Future.value(true);
    return _http.request('packages/dart_codelab/assets/piratenames.json')
      .then((HttpRequest request) {
        var r = JSON.decode(request.response);
        names = r['names'];
        appellations = r['appellations'];
      })
      .catchError((error) {
        print('Could not read data from the JSON file: $error');
      });
  }

  Future<String> randomName() {
    return _loadData().then((_) => _oneRandom(names));
  }

  Future<String> randomAppellation() {
    return _loadData().then((_) => _oneRandom(appellations));
  }

  String _oneRandom(List<String> list) => list[rand.nextInt(list.length)];
}