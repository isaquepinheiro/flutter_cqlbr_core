import '../interface/cqlbr.interface.dart';
import 'cqlbr.delete.dart';
import 'cqlbr.groupby.dart';
import 'cqlbr.having.dart';
import 'cqlbr.insert.dart';
import 'cqlbr.joins.dart';
import 'cqlbr.orderby.dart';
import 'cqlbr.register.dart';
import 'cqlbr.update.dart';
import 'cqlbr.where.dart';

class CQLAST implements ICQLAST {
  late final ICQLSelect _select;
  late final ICQLInsert _insert;
  late final ICQLUpdate _update;
  late final ICQLDelete _delete;
  late final ICQLGroupBy _groupBy;
  late final ICQLHaving _having;
  late final ICQLJoins _joins;
  late final ICQLOrderBy _orderBy;
  late final ICQLWhere _where;
  late ICQLSection? _astSection;
  late ICQLNames? _astTableNames;
  late ICQLNames? _astColumns;
  late ICQLName? _astName;

  CQLAST({required Database database}) {
    _select = CQLBrRegister.instance.select(database);
    _delete = CQLDelete();
    _insert = CQLInsert();
    _update = CQLUpdate();
    _joins = CQLJoins();
    _having = CQLHaving();
    _orderBy = CQLOrderBy();
    _groupBy = CQLGroupBy();
    if (CQLBrRegister.instance.where(database) == null) {
      _where = CQLWhere();
    }
    _astSection = null;
    _astTableNames = null;
    _astColumns = null;
    _astName = null;
  }

  @override
  bool isEmpty() {
    return _select.isEmpty() &&
        _joins.isEmpty() &&
        _where.isEmpty() &&
        _groupBy.isEmpty() &&
        _having.isEmpty() &&
        _orderBy.isEmpty() &&
        _delete.isEmpty() &&
        _insert.isEmpty() &&
        _update.isEmpty();
  }

  @override
  void clear() {
    _select.clear();
    _delete.clear();
    _insert.clear();
    _update.clear();
    _joins.clear();
    _where.clear();
    _groupBy.clear();
    _having.clear();
    _orderBy.clear();
  }

  @override
  ICQLNames? get astColumns => _astColumns;
  @override
  set astColumns(ICQLNames? value) => _astColumns = value;

  @override
  ICQLName? get astName => _astName;
  @override
  set astName(ICQLName? value) => _astName = value;

  @override
  ICQLSection? get astSection => _astSection;
  @override
  set astSection(ICQLSection? value) => _astSection = value;

  @override
  ICQLNames? get astTableNames => _astTableNames;
  @override
  set astTableNames(ICQLNames? value) => _astTableNames = value;

  @override
  ICQLDelete delete() {
    return _delete;
  }

  @override
  ICQLGroupBy groupBy() {
    return _groupBy;
  }

  @override
  ICQLHaving having() {
    return _having;
  }

  @override
  ICQLInsert insert() {
    return _insert;
  }

  @override
  ICQLJoins joins$() {
    return _joins;
  }

  @override
  ICQLOrderBy orderBy() {
    return _orderBy;
  }

  @override
  ICQLSelect select() {
    return _select;
  }

  @override
  ICQLUpdate update() {
    return _update;
  }

  @override
  ICQLWhere where() {
    return _where;
  }
}
