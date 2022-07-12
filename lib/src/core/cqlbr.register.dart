import 'package:flutter_cqlbr_core/src/core/cqlbr.delete.dart';
import 'package:flutter_cqlbr_core/src/core/cqlbr.insert.dart';
import 'package:flutter_cqlbr_core/src/core/cqlbr.where.dart';

import '../interface/cqlbr.interface.dart';
import 'cqlbr.operators.dart';
import 'cqlbr.update.dart';

class CQLBrRegister {
  late final Map<Database, ICQLSelect> cqlSelect;
  late final Map<Database, ICQLInsert> cqlInsert;
  late final Map<Database, ICQLUpdate> cqlUpdate;
  late final Map<Database, ICQLDelete> cqlDelete;
  late final Map<Database, ICQLWhere> cqlWhere;
  late final Map<Database, ICQLSerialize> cqlSerialize;
  late final Map<Database, ICQLFunctions> cqlFunctions;
  late final Map<Database, ICQLOperators> cqlOperators;

  static CQLBrRegister? _instance;

  CQLBrRegister._() {
    cqlSelect = {};
    cqlInsert = {};
    cqlUpdate = {};
    cqlDelete = {};
    cqlWhere = {};
    cqlSerialize = {};
    cqlFunctions = {};
    cqlOperators = {};
  }

  static CQLBrRegister get instance => _instance ??= CQLBrRegister._();

  void registerSelect(Database database, ICQLSelect select) {
    cqlSelect[database] = select;
  }

  void registerInsert(Database database, ICQLInsert insert) {
    cqlInsert[database] = insert;
  }

  void registerUpdate(Database database, ICQLUpdate update) {
    cqlUpdate[database] = update;
  }

  void registerDelete(Database database, ICQLDelete delete) {
    cqlDelete[database] = delete;
  }

  void registerWhere(Database database, ICQLWhere where) {
    cqlWhere[database] = where;
  }

  void registerSerialize(Database database, ICQLSerialize serialize) {
    cqlSerialize[database] = serialize;
  }

  void registerFunctions(Database database, ICQLFunctions functions) {
    cqlFunctions[database] = functions;
  }

  void registerOperators(Database database, ICQLOperators operators) {
    cqlOperators[database] = operators;
  }

  ICQLSelect select(Database database) {
    if (!cqlSelect.containsKey(database)) {
      throw Exception('Select not registered for database: $database');
    }
    return cqlSelect[database]!;
  }

  ICQLInsert insert(Database database) {
    return cqlInsert[database] ?? CQLInsert();
  }

  ICQLUpdate update(Database database) {
    return cqlUpdate[database] ?? CQLUpdate();
  }

  ICQLDelete delete(Database database) {
    return cqlDelete[database] ?? CQLDelete();
  }

  ICQLWhere where(Database database) {
    return cqlWhere[database] ?? CQLWhere();
  }

  ICQLSerialize serialize(Database database) {
    if (!cqlSerialize.containsKey(database)) {
      throw Exception('Serialize not registered for database: $database');
    }
    return cqlSerialize[database]!;
  }

  ICQLFunctions? functions(Database database) {
    return cqlFunctions[database];
  }

  ICQLOperators operators(Database database) {
    return cqlOperators[database] ?? CQLOperators(database: database);
  }
}
