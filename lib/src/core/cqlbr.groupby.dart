import '../interface/cqlbr.interface.dart';
import 'cqlbr.name.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLGroupBy extends CQLSection implements ICQLGroupBy {
  late final ICQLNames _columns;

  CQLGroupBy() : super(name: 'GroupBy') {
    _columns = CQLNames();
  }

  @override
  ICQLNames get columns => _columns;

  @override
  String serialize() {
    return isEmpty()
        ? ''
        : Utils.instance.concat(['GROUP BY', _columns.serialize()]);
  }

  @override
  void clear() {
    _columns.clear();
  }

  @override
  bool isEmpty() {
    return _columns.isEmpty();
  }
}
