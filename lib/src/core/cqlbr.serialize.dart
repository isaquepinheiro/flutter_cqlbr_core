import '../interface/cqlbr.interface.dart';
import 'cqlbr.utils.dart';

class CQLSerialize implements ICQLSerialize {
  @override
  String asString(ICQLAST ast) {
    return Utils.instance.concat([
      ast.select().serialize(),
      ast.delete().serialize(),
      ast.insert().serialize(),
      ast.update().serialize(),
      ast.joins$().serialize(),
      ast.where().serialize(),
      ast.groupBy().serialize(),
      ast.having().serialize(),
      ast.orderBy().serialize(),
    ]);
  }
}
