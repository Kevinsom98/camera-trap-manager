import 'dart:io';
import 'package:camera_trap_app/ui/form_ui.dart';
import 'package:camera_trap_app/ui/map_view_ui.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/db_model.dart';
import '../services/helper_service.dart';


class ProjectDetailScreen extends StatefulWidget {
  final ProjectFolder project;
  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final DriftService _dbService = DriftService();
  List<Map<CameraTrap, List<TrapPhoto>>> _trapsWithPhotos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTraps();
  }

  Future<void> _loadTraps() async {
    setState(() => _isLoading = true);
    final data = await _dbService.getTrapsWithPhotosForProject(widget.project.id);
    setState(() {
      _trapsWithPhotos = data;
      _isLoading = false;
    });
  }

  Future<void> _exportExcel() async {
    if (_trapsWithPhotos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No data to export.')));
      return;
    }

    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Trap Data'];
    excel.setDefaultSheet('Trap Data');

    sheetObject.appendRow([
      TextCellValue('Camera Name'),
      TextCellValue('Latitude'),
      TextCellValue('Longitude'),
      TextCellValue('GPS Accuracy (m)'),
      TextCellValue('Deployed By'),
      TextCellValue('Direction (Bearing)'),
      TextCellValue('Date & Time'),
      TextCellValue('Environment')
    ]);

    for (var item in _trapsWithPhotos) {
      final trap = item.keys.first;
      sheetObject.appendRow([
        TextCellValue(trap.trapName),
        DoubleCellValue(trap.latitude),
        DoubleCellValue(trap.longitude),
        DoubleCellValue(trap.gpsAccuracy),
        TextCellValue(trap.deployedBy),
        TextCellValue(trap.compassDirection),
        TextCellValue(trap.dateTimeDeployed.toIso8601String()),
        TextCellValue(trap.envConditions),
      ]);
    }

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${widget.project.name.replaceAll(' ', '_')}_ledger.xlsx';
    final file = File(filePath);
    
    final bytes = excel.save();
    if (bytes != null) {
      await file.writeAsBytes(bytes);
      await Share.shareXFiles([XFile(filePath)], text: 'Excel Ledger: ${widget.project.name}');
    }
  }

  Future<void> _exportPDF() async {
    if (_trapsWithPhotos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No entries to export.')));
      return;
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text('Deployment Report: ${widget.project.name}', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Text('Export Generated: ${DateTime.now().toString().split('.')[0]}', style: const pw.TextStyle(color: PdfColors.grey600)),
            pw.SizedBox(height: 15),

            ..._trapsWithPhotos.map((item) {
              final trap = item.keys.first;
              final photos = item.values.first;

              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 20),
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey400, width: 0.5)),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Trap Name: ${trap.trapName}', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
                    pw.SizedBox(height: 4),
                    pw.Text('Coordinates: ${trap.latitude.toStringAsFixed(6)}, ${trap.longitude.toStringAsFixed(6)} (±${trap.gpsAccuracy.toStringAsFixed(1)}m)'),
                    pw.Text('Operator: ${trap.deployedBy} | Orientation: ${trap.compassDirection}'),
                    pw.Text('Environment Profile: ${trap.envConditions}'),
                    pw.Text('Timestamp: ${trap.dateTimeDeployed.toString().split('.')[0]}'),
                    pw.SizedBox(height: 8),

                    photos.isEmpty 
                      ? pw.Text('[No media attached]', style:  pw.TextStyle(fontStyle: pw.FontStyle.italic, color: PdfColors.grey500))
                      : pw.GridView(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          children: photos.map((photo) {
                            final file = File(photo.localFilePath);
                            if (!file.existsSync()) return pw.Container();
                            final imageBytes = file.readAsBytesSync();
                            return pw.Image(pw.MemoryImage(imageBytes), fit: pw.BoxFit.cover);
                          }).toList(),
                        ),
                  ],
                ),
              );
            }),
          ];
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${widget.project.name.replaceAll(' ', '_')}_report.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(filePath)], text: 'PDF Report: ${widget.project.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.map, color: Colors.blue),
            tooltip: 'View on Map',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapViewScreen(project: widget.project),
                ),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.table_view, color: Colors.green), onPressed: _exportExcel, tooltip: 'Excel Export'),
          IconButton(icon: const Icon(Icons.picture_as_pdf, color: Colors.red), onPressed: _exportPDF, tooltip: 'PDF Export'),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _trapsWithPhotos.isEmpty
              ? const Center(child: Text('No camera trap structures recorded in this project.'))
              : ListView.builder(
                  itemCount: _trapsWithPhotos.length,
                  itemBuilder: (context, index) {
                    final item = _trapsWithPhotos[index];
                    final trap = item.keys.first;
                    final photos = item.values.first;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ExpansionTile(
                        leading: const Icon(Icons.pin_drop, color: Colors.blueGrey),
                        title: Text(trap.trapName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Accuracy Bound: ±${trap.gpsAccuracy.toStringAsFixed(1)}m'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Coordinates: ${trap.latitude}, ${trap.longitude}'),
                                Text('Operator: ${trap.deployedBy}'),
                                Text('Direction Matrix: ${trap.compassDirection}'),
                                Text('Environment Notes: ${trap.envConditions}'),
                                Text('Deployment Time: ${trap.dateTimeDeployed.toString().split('.')[0]}'),
                                const SizedBox(height: 10),
                                photos.isEmpty
                                    ? const Text('No images registered.', style: TextStyle(color: Colors.grey))
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 4),
                                        itemCount: photos.length,
                                        itemBuilder: (ctx, pIdx) {
                                          return Image.file(File(photos[pIdx].localFilePath), fit: BoxFit.cover);
                                        },
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCameraTrapScreen(project: widget.project)),
          );
          if (result == true) _loadTraps();
        },
        icon: const Icon(Icons.add),
        label: const Text('Deploy Trap'),
      ),
    );
  }
}