import 'package:drift/drift.dart';
import '../models/db_model.dart'; // Import your new Drift AppDatabase file


class DriftService {
  // Singleton pattern to ensure a single connection across all screens
  static final DriftService _instance = DriftService._internal();
  factory DriftService() => _instance;
  DriftService._internal();

  final AppDatabase db = AppDatabase();

  // ==========================================
  // PROJECT QUERIES
  // ==========================================
  Future<int> saveProject(ProjectFoldersCompanion project) async {
    return await db.into(db.projectFolders).insert(project);
  }

  Future<int> updateProjectFolder(int id, ProjectFoldersCompanion updatedFolder) async {
  return await (db.update(db.projectFolders)..where((t) => t.id.equals(id))).write(updatedFolder);
}

Future<int> deleteProjectFolder(int id) async {
  return await (db.delete(db.projectFolders)..where((t) => t.id.equals(id))).go();
}

// Camera Trap Adjustments
Future<int> updateCameraTrapRecord(int id, CameraTrapsCompanion updatedTrap) async {
  return await (db.update(db.cameraTraps)..where((t) => t.id.equals(id))).write(updatedTrap);
}

Future<int> deleteCameraTrapRecord(int id) async {
  return await (db.delete(db.cameraTraps)..where((t) => t.id.equals(id))).go();
}

  Future<List<ProjectFolder>> getAllProjects() async {
    return await (db.select(db.projectFolders)
          ..orderBy([(t) => OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc)]))
        .get();
  }

  // ==========================================
  // CAMERA TRAP & RELATIONAL QUERIES
  // ==========================================
  Future<void> saveCameraTrap(CameraTrapsCompanion trap, List<String> photoPaths) async {
    await db.transaction(() async {
      // 1. Insert the main trap record and get its primary auto-increment key
      final trapId = await db.into(db.cameraTraps).insert(trap);

      // 2. Insert all corresponding image file paths tied to this newly generated ID
      for (var path in photoPaths) {
        await db.into(db.trapPhotos).insert(
              TrapPhotosCompanion.insert(
                cameraTrapId: trapId,
                localFilePath: path,
                dateTaken: DateTime.now(),
              ),
            );
      }
    });
  }

  /// Fetches traps along with their pre-loaded list of photo attachments
  Future<List<Map<CameraTrap, List<TrapPhoto>>>> getTrapsWithPhotosForProject(int projectId) async {
    // Query traps belonging to the target project
    final trapsQuery = db.select(db.cameraTraps)..where((t) => t.projectId.equals(projectId));
    final traps = await trapsQuery.get();

    List<Map<CameraTrap, List<TrapPhoto>>> results = [];

    for (var trap in traps) {
      final photosQuery = db.select(db.trapPhotos)..where((p) => p.cameraTrapId.equals(trap.id));
      final photos = await photosQuery.get();
      results.add({trap: photos});
    }

    return results;
  }
}