import 'package:flutter/foundation.dart';

import '../interface/cqlbr.interface.dart';
import 'cqlbr.name.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLSelect extends CQLSection implements ICQLSelect {
  @protected
  late final ICQLNames _columns;
  @protected
  late final ICQLNames _tableNames;
  late ICQLSelectQualifiers _qualifiers;
  late Database _driver;

  CQLSelect() : super(name: 'Select') {
    _columns = CQLNames();
    _tableNames = CQLNames();
  }

  @override
  ICQLSelectQualifiers get qualifiers => _qualifiers;
  set qualifiers$(ICQLSelectQualifiers value) {
    _qualifiers = value;
  }

  @override
  Database get driver => _driver;
  @override
  set driver(Database value) {
    _driver = value;
  }

  @override
  void clear() {
    _columns.clear();
    _tableNames.clear();
    _qualifiers.clear();
  }

  @override
  ICQLNames get columns => _columns;
  set columns(ICQLNames value) {
    _columns = value;
  }

  @override
  bool isEmpty() {
    return (_columns.isEmpty() && _tableNames.isEmpty());
  }

  @override
  String serialize() {
    return isEmpty()
        ? ''
        : Utils.instance.concat([
            'SELECT',
            _qualifiers.serializeDistinct(),
            _qualifiers.serializePagination(),
            _columns.serialize(),
            'FROM',
            _tableNames.serialize(),
          ]);
  }

  @override
  ICQLNames get tableNames => _tableNames;
  set tableNames$(ICQLNames value) {
    _tableNames = value;
  }
}
