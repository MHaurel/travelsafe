import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter_frontend/models/country.dart';

/**
 * ! See the documentation and example: https://davbfr.github.io/dart_pdf/#/
 */

Future<void> downloadCountrySheet(Country country, bool isMobile) async {
  Future<pw.Image> makeLogo(bool isMobile) async {
    late Uint8List imageBytes;
    if (isMobile) {
      imageBytes = File('assets/images/logo.png').readAsBytesSync();
    } else {
      final logo = await rootBundle.load("assets/images/logo.png");
      imageBytes = logo.buffer.asUint8List();
    }
    return pw.Image(pw.MemoryImage(imageBytes));
  }

  print("downloadCountrySheet");
  final pdf = pw.Document();

  final pw.Image logoImage =
      await makeLogo(isMobile); // ? taking too long -> reduce image size

  pdf.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (context) {
      return pw.Center(
          child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          logoImage,
          pw.Text(country.name, style: pw.TextStyle(fontSize: 25)),
          pw.Text(
              DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now()).toString()),
          pw.Text("Conditions des femmes et des enfants",
              style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.womenChildrenDescription),
          pw.Text("Respect des droits LGBT", style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.lgbtDescription),
          pw.Text("Us et coutumes", style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.customsDescription),
          pw.Text("Conditions météorologiques",
              style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.climateDescription),
          pw.Text("Sociopolitique", style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.socipoliticalDescription),
          pw.Text("Sanitaires", style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.sanitaryDescription),
          pw.Text("Sécurité", style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.securityDescription),
          pw.Text("Nourriture", style: pw.TextStyle(fontSize: 20)),
          pw.Text(country.foodDescription),
        ],
      ));
    },
  ));

  if (isMobile) {
    final file = File("${country.name}.pdf");
    await file.writeAsBytes(await pdf.save());
  } else {
    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "${country.name}.pdf")
      ..click();
  }

  // ? Return true/false
}
