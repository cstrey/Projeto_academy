import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/car.dart';
import '../models/sales.dart';
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
      await db.execute(TableSales.createTable);

      await db.rawInsert(TableUser.adminUserRawInsert);
    },
    version: 1,
  );
}

// ignore: avoid_classes_with_only_static_members
class TableUser {
  static const String createTable = '''
  CREATE TABLE $tableName(
    $id       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $autonomy TEXT NOT NULL,
    $name     TEXT NOT NULL,
    $cnpj     INTEGER NOT NULL,
    $password TEXT NOT NULL,
    )
  ''';

  static const String tableName = 'user';

  static const String id = 'id';

  static const String cnpj = 'cnpj';

  static const String name = 'name';

  static const String autonomy = 'autonomy';

  static const String password = 'password';

  static const adminUserRawInsert =
      'INSERT INTO $tableName($cnpj,$name,$autonomy,$password)'
      'VALUES(123,"admin","admin","admin")';

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

    await database.delete(
      TableUser.tableName,
      where: '${TableUser.id} = ?',
      whereArgs: [person.id],
    );
  }

  Future<void> update(User person) async {
    final database = await getDatabase();

    final map = TableUser.toMap(person);

    await database.update(
      TableUser.tableName,
      map,
      where: '${TableUser.id} = ?',
      whereArgs: [person.id],
    );
    return;
  }
}

// ignore: avoid_classes_with_only_static_members
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
      $purchasedDate  TEXT NOT NULL,
      $dealershipId   INTEGER NOT NULL
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
  static const String dealershipId = 'dealership_id';

  static Map<String, dynamic> toMap(Car car) {
    final map = <String, dynamic>{};
    map[TableCars.model] = car.model;
    map[TableCars.plate] = car.plate;
    map[TableCars.brand] = car.brand;
    map[TableCars.builtYear] = car.builtYear;
    map[TableCars.modelYear] = car.modelYear;
    map[TableCars.photo] = car.photo;
    map[TableCars.pricePaid] = car.pricePaid;
    map[TableCars.purchasedDate] = car.purchasedDate;
    //map[TableCars.dealershipId] = car.dealershipId;

    return map;
  }
}

class CarsController {
  Future<void> insert(Car car) async {
    final dataBase = await getDatabase();
    final map = TableCars.toMap(car);

    await dataBase.insert(TableSales.tableName, map);

    return;
  }

  Future<List<Car>> select() async {
    final dataBase = await getDatabase();

    final List<Map<String, dynamic>> result = await dataBase.query(
      TableSales.tableName,
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
          purchasedDate: it[TableCars.purchasedDate],
          //dealershipId: it[TableCars.dealershipId],
        ),
      );
    }

    return list;
  }

  Future<void> delete(Car car) async {
    final database = await getDatabase();

    await database.delete(
      TableSales.tableName,
      where: '${TableSales.id} = ?',
      whereArgs: [car.id],
    );
  }

  Future<void> update(Car car) async {
    final database = await getDatabase();

    final map = TableCars.toMap(car);

    await database.update(
      TableSales.tableName,
      map,
      where: '${TableSales.id} = ?',
      whereArgs: [car.id],
    );
    return;
  }
}

// ignore: avoid_classes_with_only_static_members
class TableSales {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $customerCpf    INTEGER NOT NULL,
      $customerName   TEXT NOT NULL,
      $soldWhen       TEXT NOT NULL,
      $priceSold      REAL NOT NULL,
      $dealershipCut  REAL NOT NULL,
      $businessCut    REAL NOT NULL,
      $safetyCut      REAL NOT NULL,
      $vehicleId      INTERGER NOT NULL,
      $dealershipId   INTEGER NOT NULL,
      $userId         INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'sale';
  static const String id = 'id';
  static const String customerCpf = 'customer_cpf';
  static const String customerName = 'customer_name';
  static const String soldWhen = 'sold_when';
  static const String priceSold = 'price_sold';
  static const String dealershipCut = 'dealership_cut';
  static const String businessCut = 'business_cut';
  static const String safetyCut = 'safety_cut';
  static const String vehicleId = 'vehicle_id';
  static const String dealershipId = 'dealership_id';
  static const String userId = 'user_id';

  static Map<String, dynamic> toMap(Sale sale) {
    final map = <String, dynamic>{};

    map[TableSales.id] = sale.id;
    map[TableSales.customerCpf] = sale.customerCpf;
    map[TableSales.customerName] = sale.customerName;
    map[TableSales.soldWhen] = sale.soldDate;
    map[TableSales.priceSold] = sale.priceSold;
    map[TableSales.dealershipCut] = sale.dealershipCut;
    map[TableSales.businessCut] = sale.businessCut;
    map[TableSales.safetyCut] = sale.safetyCut;
    map[TableSales.vehicleId] = sale.vehicleId;
    //map[TableSales.dealershipId] = sale.dealershipId;
    map[TableSales.userId] = sale.userId;

    return map;
  }
}

class SalesController {
  Future<void> insert(Sale sale) async {
    final dataBase = await getDatabase();
    final map = TableSales.toMap(sale);

    await dataBase.insert(TableSales.tableName, map);

    return;
  }

  Future<List<Sale>> select() async {
    final dataBase = await getDatabase();

    final List<Map<String, dynamic>> result = await dataBase.query(
      TableSales.tableName,
    );

    var list = <Sale>[];

    for (final it in result) {
      list.add(
        Sale(
          id: it[TableSales.id],
          customerCpf: it[TableSales.customerCpf],
          customerName: it[TableSales.customerName],
          soldDate: it[TableSales.soldWhen],
          priceSold: it[TableSales.priceSold],
          dealershipCut: it[TableSales.dealershipCut],
          businessCut: it[TableSales.businessCut],
          safetyCut: it[TableSales.safetyCut],
          vehicleId: it[TableSales.vehicleId],
          //dealershipId: it[TableSales.dealershipId],
          userId: it[TableSales.userId],
        ),
      );
    }

    return list;
  }

  Future<void> update(Sale sale) async {
    final database = await getDatabase();

    final map = TableSales.toMap(sale);

    await database.update(
      TableSales.tableName,
      map,
      where: '${TableSales.id} = ?',
      whereArgs: [sale.id],
    );
    return;
  }
}
