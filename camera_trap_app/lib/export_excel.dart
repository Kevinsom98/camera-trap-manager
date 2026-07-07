import 'package:camera_trap_app/models/db_model.dart';
import 'package:excel/excel.dart';

void exportToExcel(List<CameraTrap> traps) {
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Trap Data'];
  excel.setDefaultSheet('Trap Data');

  // Headers
  sheetObject.appendRow([
    TextCellValue('Camera Name'),
    TextCellValue('Latitude'),
    TextCellValue('Longitude'),
    TextCellValue('Deployed By'),
    TextCellValue('Direction (Bearing)'),
    TextCellValue('Date & Time'),
    TextCellValue('Environment')
  ]);

  // Data rows
for (var trap in traps) {
  sheetObject.appendRow([
    TextCellValue(trap.trapName),
    DoubleCellValue(trap.latitude),
    DoubleCellValue(trap.longitude),
    TextCellValue(trap.deployedBy),
    TextCellValue(trap.compassDirection), // Fixed: changed bearingPointing to compassDirection
    TextCellValue(trap.dateTimeDeployed.toIso8601String()),
    TextCellValue(trap.envConditions),
  ]);
}
  
  var fileBytes = excel.save();
  // Save fileBytes locally using path_provider and invoke Share_plus
}