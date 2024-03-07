// import 'dart:io';

// import 'package:jinja/jinja.dart';
// import 'package:jinja/loaders.dart';

// void main() {
//   var templates = Platform.script.resolve('templates').toFilePath();

//   var env = Environment(
//     globals: <String, Object?>{
//       'now': () {
//         var dt = DateTime.now().toLocal();
//         var hour = dt.hour.toString().padLeft(2, '0');
//         var minute = dt.minute.toString().padLeft(2, '0');
//         return '$hour:$minute';
//       },
//     },
//     autoReload: true,
//     loader: FileSystemLoader(paths: <String>[templates]),
//     leftStripBlocks: true,
//     trimBlocks: true,
//   );

//   env.getTemplate("country_sheet.html").renderTo(HttpResponse() ,{'country': "France"}));
// }

import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("Hello World"),
        ); // Center
      })); // Page

  // Save the PDF (mobile)
  final file = File("example.pdf");
  await file.writeAsBytes(await pdf.save());

  // Save the PDF (web)
  // var savedFile = await pdf.save();
  // List<int> fileInts = List.from(savedFile);
  // html.AnchorElement(
  //     href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
  //   ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
  //   ..click();
}
