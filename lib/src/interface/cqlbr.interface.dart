enum Operator {
  opeNone(name: 'opeNone'),
  opeWhere(name: 'opeWhere'),
  opeAnd(name: 'opeAnd'),
  opeOr(name: 'opeOr');

  final String name;

  const Operator({required this.name});
}

enum Database {
  dbnSQLServer(name: 'dbnSQLServer'),
  dbnMySQL(name: 'dbnMySQL'),
  dbnPostgreSQL(name: 'dbnPostgreSQL'),
  dbnSQLite(name: 'dbnSQLite'),
  dbnOracle(name: 'dbnOracle'),
  dbnFirebird(name: 'dbnFirebird'),
  dbnInterbase(name: 'dbnInterbase'),
  dbnDB2(name: 'dbnDB2'),
  dbnMongoDB(name: 'dbnMongoDB'),
  dbnFirebase(name: 'dbnFirebase'),
  dbnASA(name: 'dbnASA'),
  dbnInformix(name: 'dbnInformix'),
  dbnNexusDB(name: 'dbnNexusDB'),
  dbnADs(name: 'dbnADs');

  final String name;

  const Database({required this.name});
}

enum ExpressionOperation {
  eoNone(name: 'eoNone'),
  eoAnd(name: 'eoAnd'),
  eoOr(name: 'eoOr'),
  eoOperation(name: 'eoOperation'),
  eoFunction(name: 'eoFunction');

  final String name;

  const ExpressionOperation({required this.name});
}

abstract class ICQLExpression {
  ICQLExpression? get left;
  set left(ICQLExpression? value);
  ExpressionOperation get operation;
  set operation(ExpressionOperation value);
  ICQLExpression? get right;
  set right(ICQLExpression? value);
  String get term;
  set term(String value);
  String serialize([bool addParens = false]);
  bool isEmpty();
  void copyWith(ICQLExpression node);
  void clear();
}

abstract class ICQLCriteriaExpression {
  ICQLCriteriaExpression and(dynamic expression);
  ICQLCriteriaExpression or(dynamic expression);
  ICQLCriteriaExpression ope(dynamic expression);
  ICQLCriteriaExpression func(dynamic expression);
  ICQLExpression? get expression;
  // set expression$(ICQLExpression? value);
  // ICQLExpression? get lastAnd;
  // set lastAnd(ICQLExpression? value);
  String asString();
}

abstract class ICQLCaseWhenThen {
  ICQLExpression get whenExpression;
  set whenExpression(ICQLExpression value);
  ICQLExpression get thenExpression;
  set thenExpression(ICQLExpression value);
}

abstract class ICQLCaseWhenList {
  ICQLCaseWhenThen whenThen(int idx);
  intsetWhenThen(int idx, ICQLCaseWhenThen value);
  ICQLCaseWhenThen add();
  int setAdd(ICQLCaseWhenThen whenThen);
  int count();
}

abstract class ICQLCase {
  ICQLExpression get caseExpression;
  set caseExpression(ICQLExpression value);
  ICQLExpression get elseExpression;
  set elseExpression(ICQLExpression value);
  ICQLCaseWhenList get whenList;
  set whenList(ICQLCaseWhenList value);
  String serialize();
}

abstract class ICQLFunctions {
  String count(String value);
  String lower(String value);
  String min(String value);
  String max(String value);
  String upper(String value);
  String substring(String value, int start, int length);
  String date(String value, [String format]);
  String day(String value);
  String month(String value);
  String year(String value);
  String concat(List<String> value);
}

abstract class ICQL {
  ICQL and$(dynamic expression);
  ICQL as$(String alias);
  ICQLCriteriaCase case$(dynamic expression);
  ICQL on$(dynamic expression);
  ICQL or$(dynamic expression);
  ICQL set$(String columnName, dynamic columnValue);
  ICQL all$();
  ICQL clear$();
  ICQL clearAll$();
  ICQL column$([dynamic columnName = '', String tableName = '']);
  ICQL delete$();
  ICQL desc$();
  ICQL distinct$();
  ICQLCriteriaExpression expression$(dynamic term);
  ICQL from$(dynamic tableName, [String alias = '']);
  ICQL groupBy$(dynamic columnName);
  ICQL having$(dynamic expression);
  ICQL fullJoin$(String tableName, [String alias = '']);
  ICQL leftJoin$(String tableName, [String alias = '']);
  ICQL rightJoin$(String tableName, [String alias = '']);
  ICQL innerJoin$(String tableName, [String alias = '']);
  ICQL insert$();
  ICQL into$(String tableName);
  bool isEmpty$();
  ICQL orderBy$(dynamic columnName);
  ICQL select$([dynamic columnName = '']);
  ICQL first$(int value);
  ICQL skip$(int value);
  ICQL limit$(int value);
  ICQL offset$(int value);
  ICQL update$(String tableName);
  ICQL where$([dynamic expression = '']);
  ICQL values$(String columnName, dynamic columnValue);
  // Operations functions
  ICQL equal$([dynamic value = '']);
  ICQL notEqual$(dynamic value);
  ICQL greaterThan$(dynamic value);
  ICQL greaterEqThan$(dynamic value);
  ICQL lessThan$(dynamic value);
  ICQL lessEqThan$(dynamic value);
  ICQL isNull$();
  ICQL isNotNull$();
  ICQL like$(String value);
  ICQL likeLeft$(String value);
  ICQL likeRight$(String value);
  ICQL notLike$(String value);
  ICQL notLikeLeft$(String value);
  ICQL notLikeRight$(String value);
  ICQL notLikeFull$(String value);
  ICQL in$(dynamic value);
  ICQL notIn$(dynamic value);
  ICQL exists$(String value);
  ICQL notExists$(String value);
  ICQL count$();
  ICQL lower$();
  ICQL min$();
  ICQL max$();
  ICQL upper$();
  ICQL substring$(int start, int length);
  ICQL date$(String value);
  ICQL day$(String value);
  ICQL month$(String value);
  ICQL year$(String value);
  ICQL concat$(List<String> value);
  ICQLFunctions asFun$();
  String asString();
}

abstract class ICQLCriteriaCase {
  ICQLCriteriaCase and$(dynamic expression);
  ICQLCriteriaCase or$(dynamic expression);
  ICQLCriteriaCase else$(dynamic value);
  ICQLCriteriaCase then$(dynamic value);
  ICQLCriteriaCase when$(dynamiccondition);
  ICQLCase get case$;
  ICQL end$();
}

abstract class ICQLName {
  String get name;
  set name(String value);
  ICQLCase get cAse;
  set case$(ICQLCase value);
  String get alias;
  set alias(String value);
  String serialize();
  bool isEmpty();
  void clear();
}

abstract class ICQLNames {
  ICQLName add();
  void setAdd(ICQLName value);
  ICQLName columns(int idx);
  int count();
  bool isEmpty();
  String serialize();
  void clear();
}

abstract class ICQLSection {
  String get name;
  bool isEmpty();
  void clear();
}

abstract class ICQLSelect extends ICQLSection {
  ICQLNames get columns;
  ICQLNames get tableNames;
  ICQLSelectQualifiers get qualifiers;
  Database get driver;
  set driver(Database value);
  String serialize();
}

abstract class ICQLWhere extends ICQLSection {
  String serialize();
  ICQLExpression get expression;
  set expression(ICQLExpression value);
}

abstract class ICQLOrderBy extends ICQLSection {
  ICQLNames columns();
  String serialize();
}

abstract class ICQLDelete extends ICQLSection {
  ICQLNames get tableNames;
  String serialize();
}

enum JoinType {
  jtInner(name: 'Inner'),
  jtLeft(name: 'Left'),
  jtRight(name: 'Right'),
  jtFull(name: 'Full');

  final String name;

  const JoinType({required this.name});
}

abstract class ICQLJoin extends ICQLSection {
  ICQLExpression get condition;
  set condition(ICQLExpression value);
  ICQLName get joinedTable;
  set joinedTable(ICQLName value);
  JoinType get joinType;
  set joinType(JoinType value);
}

abstract class ICQLGroupBy extends ICQLSection {
  ICQLNames get columns;
  String serialize();
}

abstract class ICQLHaving extends ICQLSection {
  ICQLExpression get expression;
  set expression(ICQLExpression value);
  String serialize();
}

abstract class ICQLNameValuePairs {
  ICQLNameValue add();
  setAdd(ICQLNameValue value);
  ICQLNameValue item(int idx);
  bool isEmpty();
  int count();
  void clear();
}

abstract class ICQLInsert extends ICQLSection {
  String get tableName;
  set tableName(String value);
  ICQLNames columns();
  ICQLNameValuePairs values();
  String serialize();
}

abstract class ICQLUpdate extends ICQLSection {
  String get tableName;
  set tableName(String value);
  ICQLNameValuePairs values();
  String serialize();
}

enum OrderByDirection {
  dirAscending(name: 'Asc'),
  dirDescending(name: 'Desc');

  final String name;

  const OrderByDirection({required this.name});
}

abstract class ICQLOrderByColumn extends ICQLName {
  OrderByDirection get direction;
  set direction(OrderByDirection value);
}

enum SelectQualifierType {
  sqFirst(name: 'First'),
  sqSkip(name: 'Skip'),
  sqDistinct(name: 'Distinct');

  final String name;

  const SelectQualifierType({required this.name});
}

abstract class ICQLSelectQualifier {
  SelectQualifierType get qualifier;
  set qualifier(SelectQualifierType value);
  int get value;
  set value(int value);
}

abstract class ICQLSelectQualifiers {
  ICQLSelectQualifier add();
  setAdd(ICQLSelectQualifier value);
  ICQLSelectQualifier qualifier(int idx);
  bool isEmpty();
  int count();
  bool executingPagination();
  String serializePagination();
  String serializeDistinct();
  void clear();
}

abstract class ICQLJoins {
  ICQLJoin get add;
  set add(ICQLJoin value);
  ICQLJoin joins(int idx);
  setJoins(int idx, ICQLJoin value);
  bool isEmpty();
  int count();
  String serialize();
  void clear();
}

abstract class ICQLNameValue {
  String get name;
  set name(String value);
  String get value;
  set value(String value);
  bool isEmpty();
  void clear();
}

abstract class ICQLAST {
  ICQLNames? get astColumns;
  set astColumns(ICQLNames? value);
  ICQLSection? get astSection;
  set astSection(ICQLSection? value);
  ICQLName? get astName;
  set astName(ICQLName? value);
  ICQLNames? get astTableNames;
  set astTableNames(ICQLNames? value);
  ICQLSelect select();
  ICQLDelete delete();
  ICQLInsert insert();
  ICQLUpdate update();
  ICQLJoins joins$();
  ICQLGroupBy groupBy();
  ICQLHaving having();
  ICQLOrderBy orderBy();
  ICQLWhere where();
  void clear();
  bool isEmpty();
}

abstract class ICQLSerialize {
  String asString(ICQLAST ast);
}

enum CQLOperatorCompare {
  fcEqual(name: '='),
  fcNotEqual(name: '<>'),
  fcGreater(name: '>'),
  fcGreaterEqual(name: '>='),
  fcLess(name: '<'),
  fcLessEqual(name: '<='),
  fcIn(name: 'In'),
  fcNotIn(name: 'Not In'),
  fcIsNull(name: 'Is Null'),
  fcIsNotNull(name: 'Is Not Null'),
  fcBetween(name: 'Between'),
  fcNotBetween(name: 'Not Between'),
  fcExists(name: 'Exists'),
  fcNotExists(name: 'Not Exists'),
  fcLikeFull(name: 'Like Full'),
  fcLikeLeft(name: 'Like Left'),
  fcLikeRight(name: 'Like Right'),
  fcNotLikeFull(name: 'Not Like Full'),
  fcNotLikeLeft(name: 'Not Like Left'),
  fcNotLikeRight(name: 'Not Like Right'),
  fcLike(name: 'Like'),
  fcNotLike(name: 'Not Like');

  final String name;

  const CQLOperatorCompare({required this.name});
}

enum CQLDataFieldType {
  dftUnknown(name: 'Null'),
  dftString(name: 'String'),
  dftInteger(name: 'Integer'),
  dftFloat(name: 'Float'),
  dftDate(name: 'Date'),
  dftArray(name: 'Array'),
  dftText(name: 'Text'),
  dftBoolean(name: 'Boolean'),
  dftDateTime(name: 'DateTime'),
  dftGuid(name: 'Guid');

  final String name;

  const CQLDataFieldType({required this.name});
}

abstract class ICQLOperator {
  CQLOperatorCompare get compare;
  set compare(CQLOperatorCompare value);
  String get columnName;
  set columnName(String value);
  dynamic get value;
  set value(dynamic value);
  CQLDataFieldType get dataType;
  set dataType(CQLDataFieldType value);
  String asString();
}

abstract class ICQLOperators {
  String isEqual(dynamic value);
  String isNotEqual(dynamic value);
  String isGreaterThan(dynamic value);
  String isGreaterEqThan(dynamic value);
  String isLessThan(dynamic value);
  String isLessEqThan(dynamic value);
  String isNull();
  String isNotNull();
  String isLike(String value);
  String isLikeFull(String value);
  String isLikeLeft(String value);
  String isLikeRight(String value);
  String isNotLike(String value);
  String isNotLikeFull(String value);
  String isNotLikeLeft(String value);
  String isNotLikeRight(String value);
  String isIn(dynamic value);
  String isNotIn(dynamic value);
  String isExists(String value);
  String isNotExists(String value);
}