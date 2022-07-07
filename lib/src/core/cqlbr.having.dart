import '../interface/cqlbr.interface.dart';
import 'cqlbr.expression.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLHaving extends CQLSection implements ICQLHaving {
  late ICQLExpression _expression;

  CQLHaving() : super(name: 'Having') {
    _expression = CQLExpression();
  }

  @override
  ICQLExpression get expression => _expression;
  @override
  set expression(ICQLExpression value) => _expression = value;

  @override
  String serialize() {
    return isEmpty()
        ? ''
        : Utils.instance.concat(['HAVING', _expression.serialize()]);
  }

  @override
  void clear() {
    _expression.clear();
  }

  @override
  bool isEmpty() {
    return _expression.isEmpty();
  }
}
