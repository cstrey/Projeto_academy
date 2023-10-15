import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/car.dart';
import '../models/sales.dart';
import '../models/user.dart';

/// initializes and opens a SQLite database
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
      await db.execute(TableSales.createTable);

      await db.rawInsert(TableUser.adminUserRawInsert);
    },
    version: 1,
  );
}

// ignore: avoid_classes_with_only_static_members
/// Database table for [User]
class TableUser {
  /// SQLite command for creating this table.
  static const String createTable = '''
  CREATE TABLE $tableName(
    $id       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    $autonomy TEXT NOT NULL,
    $name     TEXT NOT NULL,
    $cnpj     INTEGER NOT NULL,
    $password TEXT NOT NULL
    )
  ''';

  /// Used to make code more readable and maintainable by centralizing.
  /// the table [name] in one place,
  static const String tableName = 'user';

  /// Used to centralize the [id].
  static const String id = 'id';

  /// Used to centralize the [CNPJ] of the table.
  static const String cnpj = 'cnpj';

  /// Used to centralize the [name] of the table.
  static const String name = 'name';

  /// Used to centralize the [autonomy] of the table.
  static const String autonomy = 'autonomy';

  /// Used to centralize the [password] of the table.
  static const String password = 'password';

  /// Inserting data into a database table.
  static const adminUserRawInsert =
      'INSERT INTO $tableName($cnpj,$name,$autonomy,$password)'
      'VALUES(123,"admin","admin","admin")';

  /// Converts a [User] object into a format that can be easily
  /// used for various purposes
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

/// Manage [user] accounts and has methods for
/// [insert], [select], [delete] and [update].
class UserController {
  /// Function that inserts a [User] object into the database.
  Future<void> insert(User person) async {
    final dataBase = await getDatabase();
    final map = TableUser.toMap(person);

    await dataBase.insert(TableUser.tableName, map);

    return;
  }

  /// defines a function select that queries the SQLite database
  /// for [user] information and returns a list of [User].
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

  /// Retrieves all records from a database table,
  /// maps the data to [User] objects, and returns a list of these [User].
  Future<List<User>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      TableUser.tableName,
    );

    var list = <User>[];

    for (final item in result) {
      list.add(
        User(
          id: item[TableUser.id],
          cnpj: item[TableUser.cnpj],
          name: item[TableUser.name],
          password: item[TableUser.password],
        ),
      );
    }
    return list;
  }

  /// Deletes a [user] record from a database table.
  Future<void> delete(User person) async {
    final database = await getDatabase();

    await database.delete(
      TableUser.tableName,
      where: '${TableUser.id} = ?',
      whereArgs: [person.id],
    );
  }

  /// Updates a [user] in a SQLite database table.
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
/// Database table for [car]
class TableCars {
  /// SQLite command for creating this table.
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

  /// Used to make code more readable and maintainable by centralizing.
  /// the table [name] in one place,
  static const String tableName = 'car';

  /// Used to centralize the [id].
  static const String id = 'id';

  /// Used to centralize the [model].
  static const String model = 'model';

  /// Used to centralize the [plate].
  static const String plate = 'plate';

  /// Used to centralize the [brand].
  static const String brand = 'brand';

  /// Used to centralize the [builtYear].
  static const String builtYear = 'built_year';

  /// Used to centralize the [modelYear].
  static const String modelYear = 'model_year';

  /// Used to centralize the [photo].
  static const String photo = 'photo';

  /// Used to centralize the [pricePaid].
  static const String pricePaid = 'price_paid';

  /// Used to centralize the [purchasedDate].
  static const String purchasedDate = 'purchased_date';

  /// Used to centralize the [dealershipId].
  static const String dealershipId = 'dealership_id';

  /// Converts a [User] object into a format that can be easily
  /// used for various purposes
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
    map[TableCars.dealershipId] = car.dealershipId;

    return map;
  }
}

/// Manage [cars] and has methods for
/// [insert], [select], [delete] and [update].
class CarsController {
  /// Retrieves a list of [cars] associated with a specific
  /// [dealership] from the database and returns it as a list of [Car]
  Future<List<Car>> selectByDealership(int dealershipId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      TableCars.tableName,
      where: '${TableCars.dealershipId} = ?',
      whereArgs: [dealershipId],
    );

    var list = <Car>[];

    for (final item in result) {
      list.add(
        Car(
          id: item[TableCars.id],
          model: item[TableCars.model],
          brand: item[TableCars.brand],
          builtYear: item[TableCars.builtYear],
          plate: item[TableCars.plate],
          modelYear: item[TableCars.modelYear],
          photo: (item[TableCars.photo]).toString(),
          pricePaid: item[TableCars.pricePaid],
          purchasedDate: item[TableCars.purchasedDate],
          dealershipId: item[TableCars.dealershipId],
        ),
      );
    }
    return list;
  }

  /// Fetches a list of [Car] objects from a database by executing a query,
  /// converting the query results into [Car].
  Future<List<Car>> selectList() async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result =
        await database.query(TableCars.tableName);

    var list = <Car>[];

    for (var it in result) {
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
          dealershipId: it[TableCars.dealershipId],
        ),
      );
    }
    return list;
  }

  /// Fetches a specific [car] record from a database by its [id] and returns
  /// the information as a [Car].
  Future<Car> selectSingleVehicle(int id) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      TableCars.tableName,
      where: '${TableCars.id} = ?',
      whereArgs: [id],
    );

    final Car vehicle;

    if (result.length == 1) {
      vehicle = Car(
        id: result.first[TableCars.id],
        model: result.first[TableCars.model],
        brand: result.first[TableCars.brand],
        builtYear: result.first[TableCars.builtYear],
        plate: result.first[TableCars.plate],
        modelYear: result.first[TableCars.modelYear],
        photo: (result.first[TableCars.photo]).toString(),
        pricePaid: result.first[TableCars.pricePaid],
        purchasedDate: result.first[TableCars.purchasedDate],
        dealershipId: result.first[TableCars.dealershipId],
      );
    } else {
      throw Exception('More than one vehicle with same id');
    }
    return vehicle;
  }

  /// Inserts a [Car] object into the database after converting it to a map.
  Future<void> insert(Car car) async {
    final dataBase = await getDatabase();
    final map = TableCars.toMap(car);

    await dataBase.insert(TableCars.tableName, map);

    return;
  }

  /// defines a function select that queries the SQLite database
  /// for [car] information and returns a list of [car].
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
          purchasedDate: it[TableCars.purchasedDate],
          dealershipId: it[TableCars.dealershipId],
        ),
      );
    }

    return list;
  }

  /// Deletes a [car] record from a database table.
  Future<void> delete(Car car) async {
    final database = await getDatabase();

    await database.delete(
      TableCars.tableName,
      where: '${TableCars.id} = ?',
      whereArgs: [car.id],
    );
  }

  /// Updates a [car] in a SQLite database table.
  Future<void> update(Car car) async {
    final database = await getDatabase();

    final map = TableCars.toMap(car);

    await database.update(
      TableCars.tableName,
      map,
      where: '${TableCars.id} = ?',
      whereArgs: [car.id],
    );
    return;
  }
}

// ignore: avoid_classes_with_only_static_members
/// Database table for [sales]
class TableSales {
  /// SQLite command for creating this table.
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
      $dealershipId   INTEGER NOT NULL,
      $userId         INTEGER NOT NULL
    );
  ''';

  /// Used to make code more readable and maintainable by centralizing.
  /// the table [name] in one place,
  static const String tableName = 'sale';

  /// Used to centralize the [id].
  static const String id = 'id';

  /// Used to centralize the [customerCpf].
  static const String customerCpf = 'customer_cpf';

  /// Used to centralize the [customerName].
  static const String customerName = 'customer_name';

  /// Used to centralize the [soldWhen].
  static const String soldWhen = 'sold_when';

  /// Used to centralize the [priceSold].
  static const String priceSold = 'price_sold';

  /// Used to centralize the [dealershipCut].
  static const String dealershipCut = 'dealership_cut';

  /// Used to centralize the [businessCut].
  static const String businessCut = 'business_cut';

  /// Used to centralize the [safetyCut].
  static const String safetyCut = 'safety_cut';

  /// Used to centralize the [dealershipId].
  static const String dealershipId = 'dealership_id';

  /// Used to centralize the [userId].
  static const String userId = 'user_id';

  /// Converts a [sale] object into a format that can be easily
  /// used for various purposes
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
    map[TableSales.dealershipId] = sale.dealershipId;
    map[TableSales.userId] = sale.userId;

    return map;
  }
}

/// Manage [sale] and has methods for
/// [insert], [select], [delete] and [update].
class SalesController {
  /// Retrieves a list of [sale] associated with a specific
  /// [dealership] from the database and returns it as a list of [sale]
  Future<List<Sale>> selectByDealership(int dealershipId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      TableSales.tableName,
      where: '${TableSales.dealershipId} = ?',
      whereArgs: [dealershipId],
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
          dealershipId: it[TableSales.dealershipId],
          userId: it[TableSales.userId],
        ),
      );
    }
    return list;
  }

  /// Inserts a [sale] object into the database after converting it to a map.
  Future<void> insert(Sale sale) async {
    final dataBase = await getDatabase();
    final map = TableSales.toMap(sale);

    await dataBase.insert(TableSales.tableName, map);

    return;
  }

  /// defines a function select that queries the SQLite database
  /// for [sale] information and returns a list of [sale].
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
          dealershipId: it[TableSales.dealershipId],
          userId: it[TableSales.userId],
        ),
      );
    }

    return list;
  }

  /// Updates a [sale] in a SQLite database table.
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
