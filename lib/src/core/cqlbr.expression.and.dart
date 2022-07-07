part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionAnd on CQLCriteriaExpression {
  ICQLCriteriaExpression andExt(dynamic value) {
    if (value is List<String>) {
      return _andList(value);
    } else if (value is String) {
      return _andString(value);
    } else {
      return _andInterface(value);
    }
  }

  ICQLCriteriaExpression _andList(List<String> value) {
    return _andString(Utils.instance.sqlParamsToStr(value));
  }

  ICQLCriteriaExpression _andString(String value) {
    final ICQLExpression node = CQLExpression();
    node.term = value;
    return _andInterface(node);
  }

  ICQLCriteriaExpression _andInterface(ICQLExpression value) {
    final ICQLExpression root = _expression!;

    if (root.isEmpty()) {
      root.copyWith(value);
      _lastAnd = root;
    } else {
      final ICQLExpression node = CQLExpression();

      node.copyWith(root);
      root.left = node;
      root.operation = ExpressionOperation.eoAnd;
      root.right = value;
      _lastAnd = root.right!;
    }

    return this;
  }
}
