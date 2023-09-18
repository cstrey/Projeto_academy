import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/car.dart';
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
      await db.execute(TableCars.createTable);
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

    database.delete(
      TableUser.tableName,
      where: '${TableUser.id} = ?',
      whereArgs: [person.id],
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

class TableCars {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $model          TEXT NOT NULL,
      $plate          TEXT NOT NULL,
      $brand          TEXT NOT NULL,
      $builtYear      INTEGER NOT NULL,
      $modelYear      INTEGER NOT NULL,
      $photo          TEXT NOT NULL,
      $pricePaid      REAL NOT NULL,
      $purchasedDate  TEXT NOT NULL
    );
  ''';

  static const String tableName = 'car';
  static const String id = 'id';
  static const String model = 'model';
  static const String plate = 'plate';
  static const String brand = 'brand';
  static const String builtYear = 'built_year';
  static const String modelYear = 'model_year';
  static const String photo = 'photo';
  static const String pricePaid = 'price_paid';
  static const String purchasedDate = 'purchased_date';

  static Map<String, dynamic> toMap(Car car) {
    final map = <String, dynamic>{};
    map[TableCars.model] = car.model;
    map[TableCars.plate] = car.plate;
    map[TableCars.brand] = car.brand;
    map[TableCars.builtYear] = car.builtYear;
    map[TableCars.modelYear] = car.modelYear;
    map[TableCars.photo] = car.photo;
    map[TableCars.pricePaid] = car.pricePaid;
    map[TableCars.purchasedDate] = DateFormat('yyyy/MM/dd').format(
      car.purchasedDate,
    );

    return map;
  }
}

class CarsController {
  Future<void> insert(Car car) async {
    final dataBase = await getDatabase();
    final map = TableCars.toMap(car);

    await dataBase.insert(TableCars.tableName, map);

    return;
  }

  Future<List<Car>> select() async {
    final dataBase = await getDatabase();

    final List<Map<String, dynamic>> result = await dataBase.query(
      TableCars.tableName,
    );

    var list = <Car>[];

    for (final it in result) {
      list.add(
        Car(
          id: it[TableCars.id],
          model: it[TableCars.model],
          brand: it[TableCars.brand],
          builtYear: it[TableCars.builtYear],
          plate: it[TableCars.plate],
          modelYear: it[TableCars.modelYear],
          photo: it[TableCars.photo],
          pricePaid: it[TableCars.pricePaid],
          purchasedDate:
              DateFormat('yyyy/MM/dd').parse(it[TableCars.purchasedDate]),
        ),
      );
    }

    return list;
  }

  Future<void> delete(Car car) async {
    final database = await getDatabase();

    database.delete(
      TableCars.tableName,
      where: '${TableCars.id} = ?',
      whereArgs: [car.id],
    );
  }

  Future<void> update(Car car) async {
    final database = await getDatabase();

    final map = TableCars.toMap(car);

    database.update(
      TableCars.tableName,
      map,
      where: '${TableCars.id} = ?',
      whereArgs: [car.id],
    );
    return;
  }
}
