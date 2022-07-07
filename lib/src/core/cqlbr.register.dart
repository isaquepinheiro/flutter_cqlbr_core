import '../interface/cqlbr.interface.dart';

class CQLBrRegister {
  late final Map<Database, ICQLSelect> cqlSelect;
  late final Map<Database, ICQLInsert> cqlInsert;
  late final Map<Database, ICQLWhere> cqlWhere;
  late final Map<Database, ICQLSerialize> cqlSerialize;
  late final Map<Database, ICQLFunctions> cqlFunctions;

  static CQLBrRegister? _instance;

  CQLBrRegister._() {
    cqlSelect = {};
    cqlInsert = {};
    cqlWhere = {};
    cqlSerialize = {};
    cqlFunctions = {};
  }

  static CQLBrRegister get instance => _instance ??= CQLBrRegister._();

  void registerSelect(Database database, ICQLSelect select) {
    cqlSelect[database] = select;
  }

  void registerInsert(Database database, ICQLInsert insert) {
    cqlInsert[database] = insert;
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

  ICQLSelect select(Database database) {
    if (!cqlSelect.containsKey(database)) {
      throw Exception('Select not registered for database: $database');
    }
    return cqlSelect[database]!;
  }

  ICQLInsert? insert(Database database) {
    if (!cqlInsert.containsKey(database)) {
      return null;
    }
    return cqlInsert[database]!;
  }

  ICQLWhere? where(Database database) {
    if (!cqlWhere.containsKey(database)) {
      return null;
    }
    return cqlWhere[database]!;
  }

  ICQLSerialize serialize(Database database) {
    if (!cqlSerialize.containsKey(database)) {
      throw Exception('Serialize not registered for database: $database');
    }
    return cqlSerialize[database]!;
  }

  ICQLFunctions? functions(Database database) {
    if (!cqlFunctions.containsKey(database)) {
      return null;
    }
    return cqlFunctions[database]!;
  }
}
