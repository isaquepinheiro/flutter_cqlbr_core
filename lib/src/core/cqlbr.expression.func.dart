part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionFunc on CQLCriteriaExpression {
  ICQLCriteriaExpression funcExt(dynamic value) {
    if (value is List<String>) {
      return _funcList(value);
    } else if (value is String) {
      return _funcString(value);
    } else {
      return _funcInterface(value);
    }
  }

  ICQLCriteriaExpression _funcList(List<String> value) {
    return _funcString(Utils.instance.sqlParamsToStr(value));
  }

  ICQLCriteriaExpression _funcString(String value) {
    final ICQLExpression node = CQLExpression();
    node.term = value;

    return _funcInterface(node);
  }

  ICQLCriteriaExpression _funcInterface(ICQLExpression value) {
    final ICQLExpression node = CQLExpression();
    node.copyWith(_lastAnd);
    _lastAnd.left = node;
    _lastAnd.operation = ExpressionOperation.eoFunction;
    _lastAnd.right = value;

    return this;
  }
}
