import '../interface/cqlbr.interface.dart';
import 'cqlbr.utils.dart';

class CQLOperator implements ICQLOperator {
  final Database database;
  late final CQLOperatorCompare _compare;
  late final CQLDataFieldType _dataType;
  late String _columnName;
  late dynamic _value;

  CQLOperator({
    required this.database,
  });

  @override
  String get columnName => _columnName;
  @override
  set columnName(String value) => _columnName = value;

  @override
  CQLOperatorCompare get compare => _compare;
  @override
  set compare(CQLOperatorCompare value) => _compare = value;

  @override
  CQLDataFieldType get dataType => _dataType;
  @override
  set dataType(CQLDataFieldType value) => _dataType = value;

  @override
  dynamic get value => _value;
  @override
  set value(var value) => _value = value;

  @override
  T asResult<T extends Object>() {
    return Utils.instance.concat([
      _columnName,
      _compare.name,
      _getCompareValue(),
    ]) as T;
  }

  String _getCompareValue() {
    if (_value == null) {
      return 'NULL';
    }

    String result = '';
    switch (_dataType) {
      case CQLDataFieldType.dftString:
        result = _value.toString();
        switch (_compare) {
          case CQLOperatorCompare.fcLike:
            result = Utils.instance.concat(['\'', result, '\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLike:
            result = Utils.instance.concat(['\'', result, '\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcLikeFull:
            result =
                Utils.instance.concat(['\'%', result, '%\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLikeFull:
            result =
                Utils.instance.concat(['\'%', result, '%\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcLikeLeft:
            result = Utils.instance.concat(['\'%', result], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLikeLeft:
            result = Utils.instance.concat(['\'%', result], delimiter: '');
            break;
          case CQLOperatorCompare.fcLikeRight:
            result =
                Utils.instance.concat(['\'', result, '%\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLikeRight:
            result =
                Utils.instance.concat(['\'', result, '%\''], delimiter: '');
            break;
          default:
        }
        break;
      case CQLDataFieldType.dftInteger:
        result = _value.toString();
        break;
      case CQLDataFieldType.dftFloat:
        result = _value.toString().replaceAll(',', '.');
        break;
      case CQLDataFieldType.dftDate:
        result = '\'${Utils.instance.dateToSQLFormat(database, _value)}\'';
        break;
      case CQLDataFieldType.dftDateTime:
        result = '\'${Utils.instance.dateTimeToSQLFormat(database, _value)}\'';
        break;
      case CQLDataFieldType.dftGuid:
        result = Utils.instance.guidStrToSQLFormat(database, _value.toString());
        break;
      case CQLDataFieldType.dftArray:
        result = _arrayValueToString();
        break;
      case CQLDataFieldType.dftBoolean:
        result = _value.toString();
        break;
      case CQLDataFieldType.dftText:
        result = '($_value)';
        break;
      default:
    }

    return result;
  }

  String _arrayValueToString() {
    final List<dynamic> values = [..._value as List<dynamic>];
    String result = '(';
    dynamic value = '';

    for (int i = 0; i < values.length; i++) {
      value = values[i];
      result += i == 0 ? '' : ', ';
      result += value.runtimeType.toString() == 'String'
          ? '\'$value\''
          : value.toString().replaceAll(',', '.');
    }
    result += ')';

    return result;
  }
}

class CQLOperators implements ICQLOperators {
  final Database database;

  CQLOperators({
    required this.database,
  });

  ICQLOperator _createOperator(
    String columnName,
    dynamic value,
    CQLOperatorCompare compare,
  ) {
    final CQLOperator result = CQLOperator(
      database: database,
    );
    result.columnName = columnName;
    result.compare = compare;
    result.value = value;
    result.dataType = compare == CQLOperatorCompare.fcIn ||
            compare == CQLOperatorCompare.fcNotIn ||
            compare == CQLOperatorCompare.fcExists ||
            compare == CQLOperatorCompare.fcNotExists
        ? CQLDataFieldType.dftText
        : _resolveDataFieldType(value);

    return result;
  }

  CQLDataFieldType _resolveDataFieldType(dynamic value) {
    switch (value.runtimeType.toString()) {
      case 'String':
        return CQLDataFieldType.dftString;
      case 'int':
        return CQLDataFieldType.dftInteger;
      case '() => DateTime':
        return CQLDataFieldType.dftDateTime;
      case 'JSArray<dynamic>':
        return CQLDataFieldType.dftArray;
      case 'bool':
        return CQLDataFieldType.dftBoolean;
      case 'Null':
        return CQLDataFieldType.dftUnknown;
      default:
        return CQLDataFieldType.dftUnknown;
    }
  }

  @override
  String isEqual(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcEqual)
        .asResult<String>();
  }

  @override
  String isExists(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcExists)
        .asResult<String>();
  }

  @override
  String isGreaterEqThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcGreaterEqual)
        .asResult<String>();
  }

  @override
  String isGreaterThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcGreater)
        .asResult<String>();
  }

  @override
  String isIn(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcIn)
        .asResult<String>();
  }

  @override
  String isLessEqThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcLessEqual)
        .asResult<String>();
  }

  @override
  String isLessThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcLess)
        .asResult<String>();
  }

  @override
  String isLike(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLike)
        .asResult<String>();
  }

  @override
  String isLikeFull(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLikeFull)
        .asResult<String>();
  }

  @override
  String isLikeLeft(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLikeLeft)
        .asResult<String>();
  }

  @override
  String isLikeRight(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLikeRight)
        .asResult<String>();
  }

  @override
  String isNotEqual(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotEqual)
        .asResult<String>();
  }

  @override
  String isNotExists(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotExists)
        .asResult<String>();
  }

  @override
  String isNotIn(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotIn)
        .asResult<String>();
  }

  @override
  String isNotLike(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLike)
        .asResult<String>();
  }

  @override
  String isNotLikeFull(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLikeFull)
        .asResult<String>();
  }

  @override
  String isNotLikeLeft(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLikeLeft)
        .asResult<String>();
  }

  @override
  String isNotLikeRight(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLikeRight)
        .asResult<String>();
  }

  @override
  String isNotNull() {
    return _createOperator('', null, CQLOperatorCompare.fcIsNotNull)
        .asResult<String>();
  }

  @override
  String isNull() {
    return _createOperator('', null, CQLOperatorCompare.fcIsNull)
        .asResult<String>();
  }
}
