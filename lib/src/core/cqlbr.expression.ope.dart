part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionOpe on CQLCriteriaExpression {
  ICQLCriteriaExpression opeExt(dynamic value) {
    if (value is List<String>) {
      return _opeList(value);
    } else if (value is String) {
      return _opeString(value);
    } else {
      return _opeInterface(value);
    }
  }

  ICQLCriteriaExpression _opeList(List<String> value) {
    return _opeString(Utils.instance.sqlParamsToStr(value));
  }

  ICQLCriteriaExpression _opeString(String value) {
    final ICQLExpression node = CQLExpression();
    node.term = value;

    return _opeInterface(node);
  }

  ICQLCriteriaExpression _opeInterface(ICQLExpression value) {
    final ICQLExpression node = CQLExpression();

    node.copyWith(_lastAnd);
    _lastAnd.left = node;
    _lastAnd.operation = ExpressionOperation.eoOperation;
    _lastAnd.right = value;

    return this;
  }
}
