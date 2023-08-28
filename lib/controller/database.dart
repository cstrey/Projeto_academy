import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'users.db',
  );

  return openDatabase(
    path,
    onCreate: (Database db, int version) async {
      db.execute(TableUser.createTable);
    },
    version: 1,
  );
}

class TableUser {
  static const String createTable = '''
  CREATE TABLE $tableName(
    $id       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $autonomy TEXT NOT NULL,
    $name     TEXT NOT NULL,
    $cnpj     INTEGER NOT NULL,
    $password TEXT NOT NULL
    );
  ''';

  static const String tableName = 'user';

  static const String id = 'id';

  static const String cnpj = 'cnpj';

  static const String name = 'name';

  static const String autonomy = 'autonomy';

  static const String password = 'password';

  static Map<String, dynamic> toMap(User person) {
    final map = <String, dynamic>{};

    map[TableUser.id] = person.id;
    map[TableUser.autonomy] = person.autonomy;
    map[TableUser.name] = person.name;
    map[TableUser.cnpj] = person.cnpj;
    map[TableUser.password] = person.password;

    return map;
  }
}

class UserController {
  Future<void> insert(User person) async {
    final dataBase = await getDatabase();
    final map = TableUser.toMap(person);

    await dataBase.insert(TableUser.tableName, map);

    return;
  }

  Future<List<User>> select() async {
    final dataBase = await getDatabase();

    final List<Map<String, dynamic>> result = await dataBase.query(
      TableUser.tableName,
    );

    var list = <User>[];

    for (final index in result) {
      list.add(
        User(
          id: index[TableUser.id],
          autonomy: index[TableUser.autonomy],
          name: index[TableUser.name],
          cnpj: index[TableUser.cnpj],
          password: index[TableUser.password],
        ),
      );
    }

    return list;
  }
}
