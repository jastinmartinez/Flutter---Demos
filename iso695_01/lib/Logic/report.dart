import 'dart:io';
import 'dart:ui';
import 'package:path/path.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class Report {
  static Future<void> generateReport() async {
    //Create a new PDF document
    final PdfDocument document = PdfDocument();

    //Create a PDF page template and add a header content
    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));

    //Draw text to the header
    headerTemplate.graphics.drawString(
      'Reporte Empleados',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: const Rect.fromLTWH(0, 15, 200, 20),
    );

    //Add the header element to the document
    document.template.top = headerTemplate;

    //add a new page to the document
    final PdfPage page = document.pages.add();
    //Create a PDF grid class to add tables
    final PdfGrid grid = PdfGrid();

    //specify the amount of columns
    grid.columns.add(count: 4);

    //add header to grid
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Id';
    headerRow.cells[1].value = 'Empleado';
    headerRow.cells[2].value = 'Departamento';
    headerRow.cells[3].value = 'Puesto';

    //add font to header rows
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '1';
    row.cells[1].value = 'Jastin Martinez';
    row.cells[2].value = 'IT';
    row.cells[3].value = 'Software Developer';

    row = grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = 'Omar de Jesus';
    row.cells[2].value = 'Teacher';
    row.cells[3].value = 'College Teacher';

    row = grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = 'Victor Ciprian';
    row.cells[2].value = 'IT';
    row.cells[3].value = 'IT Coordinator';

    row = grid.rows.add();
    row.cells[0].value = '4';
    row.cells[1].value = 'Gregory Hidalgo';
    row.cells[2].value = 'IT';
    row.cells[3].value = 'Sr. Software Developer';

    //set grid format
    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);

    //Draw table to pdf Page
    grid.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 0, page.getClientSize().width, page.getClientSize().height),
    );
    //Save the document
    final getDir = await path_provider.getApplicationDocumentsDirectory();
    String path = join(getDir.path, 'example.pdf');
    File(path).writeAsBytes(
      document.save(),
    );
    document.dispose();
  }

  static Future<void> callReport() async {}
}
