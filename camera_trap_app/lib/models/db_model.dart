import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'db_model.g.dart'; // Run `dart run build_runner build` to generate this

// ==========================================
// TABLE DEFINITIONS (SCHEMAS)
// ==========================================

class ProjectFolders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  DateTimeColumn get dateCreated => dateTime()();
}

class CameraTraps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  
  // Relational link to parent project with cascading deletes
  IntColumn get projectId => integer().references(
        ProjectFolders, 
        #id, 
        onDelete: KeyAction.cascade,
      )();

  TextColumn get trapName => text().withLength(min: 1, max: 255)();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get gpsAccuracy => real()();
  TextColumn get deployedBy => text()();
  TextColumn get compassDirection => text()();
  DateTimeColumn get dateTimeDeployed => dateTime()();
  TextColumn get envConditions => text()();
}

class TrapPhotos extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Relational link to parent camera trap with cascading deletes
  IntColumn get cameraTrapId => integer().references(
        CameraTraps, 
        #id, 
        onDelete: KeyAction.cascade,
      )();

  TextColumn get localFilePath => text()();
  DateTimeColumn get dateTaken => dateTime()();
}

// ==========================================
// DATABASE ACCESS LAYER (CONSTRUCTOR)
// ==========================================

@DriftDatabase(tables: [ProjectFolders, CameraTraps, TrapPhotos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // drift_flutter automatically handles optimal pathing on mobile devices
    return driftDatabase(name: 'camera_trap_database');
  }
}