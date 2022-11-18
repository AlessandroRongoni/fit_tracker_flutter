import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Model/alimento.dart';
import 'Model/diario.dart';

class FitTrackerDatabase{
  static final FitTrackerDatabase instance = FitTrackerDatabase._init();
  static Database? _database;
  FitTrackerDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;            //Se il db non esiste lo creo altrimenti ritorno quello esistente
    _database=await _initDB('fit_tracker_database.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filePath);         //Cerco il db se esiste

    return await openDatabase(path, version:1, onCreate: _createDB,);
  }
  Future _createDB(Database db, int version) async{         //Creazione db
    await db.execute('''
CREATE TABLE $tableAlimenti(
  ${AlimentoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${AlimentoFields.nome} TEXT NOT NULL,
  ${AlimentoFields.kcal} INTEGER NOT NULL,
  ${AlimentoFields.carbo} REAL NOT NULL,
  ${AlimentoFields.grassi} REAL NOT NULL,
  ${AlimentoFields.proteine} REAL NOT NULL,
  ${AlimentoFields.user} TEXT NOT NULL
)''');
    await db.execute('''
CREATE TABLE $tableDiari(
  ${DiarioFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${DiarioFields.pasto} TEXT NOT NULL,
  ${DiarioFields.alimento} INTEGER NOT NULL,
  ${DiarioFields.quantita} REAL NOT NULL,
  ${DiarioFields.giorno} TEXT NOT NULL,
  ${DiarioFields.utente} TEXT NOT NULL
)''');
  }


  Future<Alimento> create(Alimento alimento) async {        //Creo alimento
    final db = await instance.database;

    final id = await db.insert(tableAlimenti, alimento.toMap());
    return alimento.copy(id: id);
  }

  Future<Alimento?> readAlimento(int id) async {        //leggo alimento da id
    final db = await instance.database;
    final maps = await db.query(
      tableAlimenti,
      columns: AlimentoFields.values,
      where: '${AlimentoFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Alimento.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Alimento>> readAllAlimenti(String utente) async {         //leggo tutti gli alimenti di un utente
    final db = await instance.database;
    final result = await db.query(tableAlimenti, where: '${AlimentoFields.user} = ?', whereArgs: [utente]);
    return result.map((json) => Alimento.fromMap(json)).toList();
  }

  Future<int> update(Alimento alimento) async {       //modifico un alimento
    final db = await instance.database;
    return db.update(
      tableAlimenti,
      alimento.toMap(),
      where: '${AlimentoFields.id} = ?',
      whereArgs: [alimento.id],
    );
  }

  Future<int> delete(int id) async {            //cancello un alimento
    final db = await instance.database;
    return await db.delete(
      tableAlimenti,
      where: '${AlimentoFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{                   //chiudo il db
    final db = await instance.database;
    db.close;
  }

  Future<Diario> createDiario(Diario diario) async {          //creo un diario
    final db = await instance.database;

    final id = await db.insert(tableDiari, diario.toMap());
    return diario.copy(id: id);
  }

  Future<Diario?> readDiario(int id) async {            //leggo un diario da id
    final db = await instance.database;
    final maps = await db.query(
      tableAlimenti,
      columns: DiarioFields.values,
      where: '${DiarioFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Diario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Diario>> readAllDiari(String utente, String data, String pasto) async {     //leggo tutti i diari di un giorno di un utente per pasto
    final db = await instance.database;
    final result = await db.query(tableDiari, where: '${DiarioFields.utente} = ? AND ${DiarioFields.giorno} = ? AND ${DiarioFields.pasto} = ?', whereArgs: [utente,data,pasto]);
    return result.map((json) => Diario.fromMap(json)).toList();
  }

  Future<List<Diario>> readAllDiariDay(String utente, String data) async {      //leggo tutti i diari di un giorno di un utente
    final db = await instance.database;
    final result = await db.query(tableDiari, where: '${DiarioFields.utente} = ? AND ${DiarioFields.giorno} = ?', whereArgs: [utente,data]);
    return result.map((json) => Diario.fromMap(json)).toList();
  }

  Future<int> updateDiario(Diario diario) async {         //modifico un diario
    final db = await instance.database;
    return db.update(
      tableDiari,
      diario.toMap(),
      where: '${DiarioFields.id} = ?',
      whereArgs: [diario.id],
    );
  }

  Future<int> deleteDiario(int id) async {          //elimino un diario
    final db = await instance.database;
    return await db.delete(
      tableDiari,
      where: '${DiarioFields.id} = ?',
      whereArgs: [id],
    );
  }

}