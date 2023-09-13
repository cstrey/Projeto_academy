import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'user.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(TableUser.createTable);
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
    )
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

    for (final it in result) {
      list.add(
        User(
          id: it[TableUser.id],
          autonomy: it[TableUser.autonomy],
          name: it[TableUser.name],
          cnpj: it[TableUser.cnpj],
          password: it[TableUser.password],
        ),
      );
    }

    return list;
  }

  Future<void> delete(User person) async {
    final database = await getDatabase();

    await database.transaction(
      (tx) async {
        final batch = tx.batch();

        batch.delete(
          TableUser.tableName,
          where: '${TableUser.id} = ?',
          whereArgs: [person.id],
        );

        await batch.commit();
      },
    );
  }

  Future<void> update(User person) async {
    final database = await getDatabase();

    final map = TableUser.toMap(person);

    database.update(
      TableUser.tableName,
      map,
      where: '${TableUser.id} = ?',
      whereArgs: [person.id],
    );
    return;
  }
}
