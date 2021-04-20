import 'package:flutter/material.dart';
import 'package:iso695_01/Logic/report.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// ignore: must_be_immutable
class ReportScreen extends StatelessWidget {
  String path;
  Future example() async {
    final getDir = await path_provider.getApplicationDocumentsDirectory();
    path = join(getDir.path, 'example.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte'),
        backgroundColor: const Color(0xFF035AA6),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            FlatButton(
              child: Text('Generar Report'),
              onPressed: () async => await Report.generateReport(),
              color: Colors.amber,
            ),
            FutureBuilder(
              future: example(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print(path);
                  return SfPdfViewerTheme(
                    child: SfPdfViewer.asset(path),
                  );
                } else {
                  return Container(
                    color: Colors.white,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
