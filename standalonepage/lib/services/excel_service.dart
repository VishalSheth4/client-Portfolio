import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ExcelService {
  static Future<String> get _filePath async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/contact_forms.xlsx';
  }

  static Future<void> saveContactForm(
      String name, String email, String message) async {
    try {
      final path = await _filePath;
      late Excel excel;
      
      // Check if file exists
      if (File(path).existsSync()) {
        final bytes = File(path).readAsBytesSync();
        excel = Excel.decodeBytes(bytes);
      } else {
        excel = Excel.createExcel();
      }

      final Sheet sheet = excel['Contact Forms'];

      // Add headers if sheet is empty
      if (sheet.maxRows == 0) {
        sheet.appendRow([
          'Name',
          'Email',
          'Message',
          'Date',
          'Status',
        ]);
      }

      // Add new form submission with timestamp
      final now = DateTime.now();
      final formattedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')} '
          '${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}';

      sheet.appendRow([
        name,
        email,
        message,
        formattedDate,
        'New',
      ]);

      // Auto-size columns
      for (var i = 0; i < 5; i++) {
        sheet.setColWidth(i, 20.0);
      }
      sheet.setColWidth(2, 40.0); // Make message column wider

      // Style headers
      var headerRow = sheet.row(0);
      for (var cell in headerRow) {
        cell?.cellStyle = CellStyle(
          bold: true,
          horizontalAlign: HorizontalAlign.Center,
          backgroundColorHex: '#E0E0E0',
        );
      }

      // Save the file
      final List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
      }

      print('Form saved successfully to: $path');
    } catch (e) {
      print('Error saving to Excel: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, String>>> getSubmissions() async {
    try {
      final path = await _filePath;
      if (!File(path).existsSync()) {
        return [];
      }

      final bytes = File(path).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);
      final Sheet sheet = excel['Contact Forms'];

      List<Map<String, String>> submissions = [];
      List<String> headers = [];

      // Get headers
      for (var cell in sheet.row(0)) {
        headers.add(cell?.value?.toString() ?? '');
      }

      // Get data
      for (var i = 1; i < sheet.maxRows; i++) {
        var row = sheet.row(i);
        Map<String, String> submission = {};
        
        for (var j = 0; j < headers.length; j++) {
          submission[headers[j]] = row[j]?.value?.toString() ?? '';
        }
        
        submissions.add(submission);
      }

      return submissions;
    } catch (e) {
      print('Error reading Excel file: $e');
      return [];
    }
  }

  static Future<String> getFilePath() async {
    return await _filePath;
  }
} 