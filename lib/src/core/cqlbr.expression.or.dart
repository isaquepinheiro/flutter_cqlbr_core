part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionOr on CQLCriteriaExpression {
  ICQLCriteriaExpression orExt(dynamic value) {
    if (value is List<String>) {
      return _orList(value);
    } else if (value is String) {
      return _orString(value);
    } else {
      return _orInterface(value);
    }
  }

  ICQLCriteriaExpression _orList(List<String> value) {
    return _orString(Utils.instance.sqlParamsToStr(value));
  }

  ICQLCriteriaExpression _orString(String value) {
    final ICQLExpression node = CQLExpression();
    node.term = value;

    return _orInterface(node);
  }

  ICQLCriteriaExpression _orInterface(ICQLExpression value) {
    final ICQLExpression root = _lastAnd;
    final ICQLExpression node = CQLExpression();
    node.copyWith(root);
    root.left = node;
    root.operation = ExpressionOperation.eoOr;
    root.right = value;
    _lastAnd = root.right!;

    return this;
  }
}
