import '../interface/cqlbr.interface.dart';

class Utils {
  static Utils? _instance;

  Utils._();

  static Utils get instance => _instance ??= Utils._();

  String concat(List<String> elements, {String delimiter = ' '}) {
    String result = '';

    for (final String value in elements) {
      if (value.isNotEmpty) {
        result = _addToList(result, delimiter, value);
      }
    }

    return result;
  }

  String sqlParamsToStr(List<dynamic> params) {
    String result = '';
    String param = '';
    String lastch = '';

    for (int i = 0; i < params.length; i++) {
      param = params[i].toString();
      if (result == '') {
        lastch = ' ';
      } else {
        lastch = result[result.length];
      }
      if (lastch != '.' &&
          lastch != '(' &&
          lastch != ' ' &&
          lastch != ':' &&
          param != ',' &&
          param != '.' &&
          param != ')') {
        result += ' ';
      }
      result += param;
    }

    return result;
  }

  String dateToSQLFormat(Database database, DateTime date) {
    switch (database) {
      case Database.dbnADs:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnASA:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnDB2:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnFirebase:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnFirebird:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnInformix:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnInterbase:
        return '${date.month}/${date.year}/${date.day}';
      case Database.dbnMongoDB:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnMySQL:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnNexusDB:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnOracle:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnPostgreSQL:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnSQLServer:
        return '${date.year}-${date.month}-${date.day}';
      case Database.dbnSQLite:
        return '${date.year}-${date.month}-${date.day}';
      default:
        return '${date.year}-${date.month}-${date.day}';
    }
  }

  String dateTimeToSQLFormat(Database database, DateTime date) {
    switch (database) {
      case Database.dbnADs:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnASA:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnDB2:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnFirebase:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnFirebird:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnInformix:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnInterbase:
        return '${date.month}/${date.year}/${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnMongoDB:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnMySQL:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnNexusDB:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnOracle:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnPostgreSQL:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnSQLServer:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case Database.dbnSQLite:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      default:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
    }
  }

  String guidStrToSQLFormat(Database database, String guid) {
    switch (database) {
      case Database.dbnADs:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnASA:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnDB2:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnFirebase:
        return 'CHAR_TO_UUID(' '$guid' ')';
      case Database.dbnFirebird:
        return 'CHAR_TO_UUID(' '$guid' ')';
      case Database.dbnInformix:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnInterbase:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnMongoDB:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnMySQL:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnNexusDB:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnOracle:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnPostgreSQL:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnSQLServer:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case Database.dbnSQLite:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      default:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
    }
  }

  String _addToList(String list, String delimiter, String element) {
    String result = list;

    if (result.isNotEmpty) {
      result += delimiter;
    }
    result += element;

    return result;
  }
}
