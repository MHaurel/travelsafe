import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_frontend/models/risk.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: constant_identifier_names
const INDEF = "Aucune information de contre-indications";

class Country {
  int id;
  String name;
  DateTime lastEdition;

  Risk? riskWomenChildren;
  Risk? riskLgbt;
  Risk? riskCustoms;
  Risk? riskClimate;
  Risk? riskSociopolitical;
  Risk? riskSanitary;
  Risk? riskSecurity;
  Risk? riskFood;

  Country(
      this.id,
      this.name,
      this.lastEdition,
      this.riskWomenChildren,
      this.riskLgbt,
      this.riskCustoms,
      this.riskClimate,
      this.riskSociopolitical,
      this.riskSanitary,
      this.riskSecurity,
      this.riskFood);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['id'],
      json['name'],
      DateTime.parse(json['last_edition']),
      Risk.fromJsonOrNull(json['risk_women_children']),
      Risk.fromJsonOrNull(json['risk_lgbt']),
      Risk.fromJsonOrNull(json['risk_customs']),
      Risk.fromJsonOrNull(json['risk_climate']),
      Risk.fromJsonOrNull(json['risk_sociopolitical']),
      Risk.fromJsonOrNull(json['risk_sanitary']),
      Risk.fromJsonOrNull(json['risk_security']),
      Risk.fromJsonOrNull(json['risk_food']),
    );
  }

  get level {
    List<Risk?> risks = [
      riskWomenChildren,
      riskLgbt,
      riskCustoms,
      riskClimate,
      riskSociopolitical,
      riskSanitary,
      riskSecurity,
      riskFood
    ];

    int sum = 0;
    int notNullNb = 0;
    for (var element in risks) {
      if (element != null) {
        sum += element.level;
        notNullNb++;
      }
    }

    if (notNullNb == 0) notNullNb++;

    return (sum / notNullNb).round();
  }

  String get womenChildrenDescription {
    if (riskWomenChildren == null) {
      return INDEF;
    }
    return riskWomenChildren!.description;
  }

  String get lgbtDescription {
    if (riskLgbt == null) {
      return INDEF;
    }
    return riskLgbt!.description;
  }

  String get customsDescription {
    if (riskCustoms == null) {
      return INDEF;
    }
    return riskCustoms!.description;
  }

  String get climateDescription {
    if (riskClimate == null) {
      return INDEF;
    }
    return riskClimate!.description;
  }

  String get socipoliticalDescription {
    if (riskSociopolitical == null) {
      return INDEF;
    }
    return riskSociopolitical!.description;
  }

  String get sanitaryDescription {
    if (riskSanitary == null) {
      return INDEF;
    }
    return riskSanitary!.description;
  }

  String get securityDescription {
    if (riskSecurity == null) {
      return INDEF;
    }
    return riskSecurity!.description;
  }

  String get foodDescription {
    if (riskFood == null) {
      return INDEF;
    }
    return riskFood!.description;
  }

  String get properDateCreated {
    Intl.defaultLocale = "fr";
    String formattedDate = DateFormat('dd/MM/yyyy').format(lastEdition);
    return formattedDate;
  }

  Future<void> buildPdf(bool isMobile) async {
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

    final doc = pw.Document();

    final pw.Image logoImage =
        await makeLogo(isMobile); // ? taking too long -> reduce image size

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Center(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            logoImage,
            pw.Text(name, style: const pw.TextStyle(fontSize: 25)),
            pw.Text(DateFormat("dd/MM/yyyy hh:mm")
                .format(DateTime.now().toLocal())
                .toString()),
          ],
        ));
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Conditions des femmes et des enfants",
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(womenChildrenDescription),
          ],
        );
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Respect des droits LGBT",
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(lgbtDescription),
          ],
        );
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Expanded(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Us et coutumes", style: const pw.TextStyle(fontSize: 20)),
            pw.Text(customsDescription),
          ],
        ));
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Conditions météorologiques",
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(climateDescription),
          ],
        );
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Climat sociopolitique",
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(socipoliticalDescription),
          ],
        );
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Conditions sanitaires",
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(sanitaryDescription),
          ],
        );
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Sécurité du pays",
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(securityDescription),
          ],
        );
      },
    ));

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Risques liés à la nourriture",
                style: const pw.TextStyle(fontSize: 20)),
            pw.Text(foodDescription),
          ],
        );
      },
    ));

    final savedFile = await doc.save();
    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "TravelSafe - $name.pdf")
      ..click();
  }

  pw.PageTheme _buildTheme() {
    return pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
      ),
    );
  }

  @override
  String toString() {
    return name;
  }
}
