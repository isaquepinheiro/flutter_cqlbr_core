import '../interface/cqlbr.interface.dart';
import 'cqlbr.utils.dart';

part 'cqlbr.expression.and.dart';
part 'cqlbr.expression.func.dart';
part 'cqlbr.expression.ope.dart';
part 'cqlbr.expression.or.dart';

class CQLExpression extends ICQLExpression {
  late ICQLExpression? _left;
  late ICQLExpression? _right;
  late ExpressionOperation _operation;
  late String _term;

  CQLExpression() {
    clear();
  }

  @override
  ICQLExpression? get left => _left;
  @override
  set left(ICQLExpression? value) => _left = value;

  @override
  ExpressionOperation get operation => _operation;
  @override
  set operation(ExpressionOperation value) => _operation = value;

  @override
  ICQLExpression? get right => _right;
  @override
  set right(ICQLExpression? value) => _right = value;

  @override
  String get term => _term;
  @override
  set term(String value) => _term = value;

  @override
  void clear() {
    _left = null;
    _right = null;
    _operation = ExpressionOperation.eoNone;
    _term = '';
  }

  @override
  bool isEmpty() {
    return ((_term.isEmpty) && (_operation == ExpressionOperation.eoNone));
  }

  @override
  void copyWith(ICQLExpression node) {
    _left = node.left;
    _right = node.right;
    _operation = node.operation;
    _term = node.term;
  }

  @override
  T serialize<T extends Object>([bool addParens = false]) {
    if (isEmpty()) {
      return '' as T;
    }
    switch (_operation) {
      case ExpressionOperation.eoNone:
        return _serializeWhere(addParens) as T;
      case ExpressionOperation.eoAnd:
        return _serializeAND() as T;
      case ExpressionOperation.eoOr:
        return _serializeOR() as T;
      case ExpressionOperation.eoOperation:
        return _serializeOperator() as T;
      case ExpressionOperation.eoFunction:
        return _serializeFunction() as T;
      default:
        throw Exception(
            'CQLExpression.Serialize: Unknown expression operation: $_operation');
    }
  }

  String _serializeWhere(bool addParens) {
    return addParens ? '($_term)' : _term;
  }

  String _serializeAND() {
    return Utils.instance
        .concat([_left?.serialize(true), 'AND', _right?.serialize(true)]);
  }

  String _serializeOR() {
    final String result = Utils.instance
        .concat([_left?.serialize(true), 'OR', _right?.serialize(true)]);

    return '($result)';
  }

  String _serializeOperator() {
    final result =
        Utils.instance.concat([_left?.serialize(), _right?.serialize()]);

    return '($result)';
  }

  String _serializeFunction() {
    return Utils.instance.concat([_left!.serialize(), _right!.serialize()]);
  }
}

class CQLCriteriaExpression implements ICQLCriteriaExpression {
  late ICQLExpression? _expression;
  late ICQLExpression _lastAnd;

  CQLCriteriaExpression(
      {ICQLExpression? expression, String expressionStr = ''}) {
    if (expression == null) {
      _expression = CQLExpression();
      if (expressionStr.isNotEmpty) {
        and(expressionStr);
      }
    } else {
      _expression = expression;
      _lastAnd = _findRightmostAnd(expression);
    }
  }

  set lastAnd(ICQLExpression? value) => _lastAnd = value!;

  ICQLExpression _findRightmostAnd(ICQLExpression value) {
    switch (value.operation) {
      case ExpressionOperation.eoNone:
        return _expression!;
      case ExpressionOperation.eoOr:
        return _expression!;
      default:
        return _findRightmostAnd(value.right!);
    }
  }

  @override
  ICQLExpression get expression => _expression!;

  @override
  ICQLCriteriaExpression and(dynamic expression) {
    return andExt(expression);
  }

  @override
  ICQLCriteriaExpression func(dynamic expression) {
    return funcExt(expression);
  }

  @override
  ICQLCriteriaExpression ope(dynamic expression) {
    return opeExt(expression);
  }

  @override
  ICQLCriteriaExpression or(dynamic expression) {
    return orExt(expression);
  }

  @override
  T asResult<T extends Object>() => _expression!.serialize<T>();
}
