import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfGenerate {
  static Future<File> generateCenterText(String title) async {
    final font = await PdfGoogleFonts.sansitaBold();
    final pdf = Document();

    pdf.addPage(Page(
        build: (context) => Center(
            child: Text(title, style: TextStyle(font: font, fontSize: 26)))));

    return saveDocument(title: 'test.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String title, required Document pdf}) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$title');
    await file.writeAsBytes(bytes);
    print("done");

    return file;
  }

  static saveMultiPage() async {
    final customFront =
        Font.ttf(await rootBundle.load("assets/Combo-Regular.ttf"));
    final customFront1 =
        Font.ttf(await rootBundle.load("assets/NanumMyeongjo-Regular.ttf"));

    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildTitleWithImage(customFront1),
          SizedBox(height: 20),
          buildCustomHeader(customFront1),
          SizedBox(height: 20),
          link(),
          SizedBox(height: 20),
          ...buildBullet(customFront),
          SizedBox(height: 20),
          paragraph(customFront),
          SizedBox(height: 20),
          paragraph(customFront),
          SizedBox(height: 20),
          paragraph(customFront),
          SizedBox(height: 20),
          paragraph(customFront),
          SizedBox(height: 20),
          paragraph(customFront),
          SizedBox(height: 20),
          paragraph(customFront),
          Table(
              border: const TableBorder(
                  right: BorderSide(width: 2),
                  left: BorderSide(width: 2),
                  top: BorderSide(width: 2),
                  bottom: BorderSide(width: 2),
                  horizontalInside: BorderSide(width: 2),
                  verticalInside: BorderSide(width: 2)),
              children: [
                for (var i = 0; i <= 5; i++)
                  TableRow(children: [
                    paddedHeadingTextCell('Product'),
                    paddedHeadingTextCell('Unit'),
                    paddedHeadingTextCell('Qty'),
                    paddedHeadingTextCell('Price'),
                    paddedHeadingTextCell('Discount'),
                    paddedHeadingTextCell('Tax'),
                    paddedHeadingTextCell('Total AUD')
                  ]),
              ])
        ],
        header: (context) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              margin: const EdgeInsets.only(bottom: 1 * PdfPageFormat.cm),
              child: Text(
                "Divyang Parmar",
                style: const TextStyle(color: PdfColors.black),
              )),
          Container(
              margin: const EdgeInsets.only(bottom: 1 * PdfPageFormat.cm),
              child: Text(
                "Page ${context.pageNumber} of ${context.pagesCount}",
                style: const TextStyle(color: PdfColors.black),
              )),
        ]),
        footer: (context) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              margin: const EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              child: Text(
                "Divyang Parmar",
                style: const TextStyle(color: PdfColors.black),
              )),
          Container(
              margin: const EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              child: Text(
                "Page ${context.pageNumber} of ${context.pagesCount}",
                style: const TextStyle(color: PdfColors.black),
              )),
        ]),
      ),
    );
    return saveDocument(title: 'test.pdf', pdf: pdf);
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }

  static List<Widget> buildBullet(Font font) => [
        Bullet(
            text: "test 1",
            style: TextStyle(font: font),
            bulletShape: BoxShape.rectangle),
        Bullet(text: "test 2", style: TextStyle(font: font)),
        Bullet(
            text: "test 3",
            style: TextStyle(font: font),
            bulletShape: BoxShape.rectangle),
      ];

  static link() => UrlLink(
      child: Text("Get Pdf Making Youtube video",
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          )),
      destination: 'https://www.youtube.com/watch?v=9nhZO88p1lY');

  static buildCustomHeader(Font? font) => Header(
      child: Text("Header Test",
          style: TextStyle(
              fontSize: 24,
              font: font,
              fontWeight: FontWeight.bold,
              color: PdfColors.white)),
      decoration: const BoxDecoration(color: PdfColors.black));

  static buildTitleWithImage(Font? font) {
    return Row(children: [
      PdfLogo(),
      SizedBox(width: 0.5 * PdfPageFormat.cm),
      Text("Create Your PDF",
          style: TextStyle(fontSize: 30, color: PdfColors.black, font: font))
    ]);
  }
}

Paragraph paragraph(Font? font) =>
    Paragraph(text: getString(), style: TextStyle(font: font));

Padding paddedHeadingTextCell(String textContent) {
  return Padding(
    padding: const EdgeInsets.all(4),
    child: Column(children: [
      Text(textContent),
    ]),
  );
}

String getString() {
  String data = "";
  for (var i = 0; i <= 1000; i++) {
    data += alpha[Random().nextInt(23)];
  }
  return data;
}

List<String> alpha = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
];
