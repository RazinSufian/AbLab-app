import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/components/pdfDownloader.dart';
import '../../utils/utils.dart';
import '../../view_model/report_details_view_model.dart'; // Assuming this is your ViewModel

// This function generates the PDF and then triggers the download
Future<void> downloadBillPdf(BuildContext context, ReportDetailsViewModel viewModel) async {
  try {
    // Show the loading indicator before generating the PDF
     Utils.showLoading(context);

    // Generate the PDF
    final generatedFile = await generateBillPdf(viewModel);

    if (generatedFile != null) {
      Utils.cancelLoading(context);
      // Download the generated PDF
      await downloadPdf(context, generatedFile, 'patient_bill_report');
    } else {
      print('PDF generation failed');
    }
  } finally {
    // Always hide the loading indicator, whether success or failure
    print('PDF download complete');

  }
}


// Helper function to create and generate the PDF
Future<File?> generateBillPdf(ReportDetailsViewModel viewModel) async {
  try {
    final patient = viewModel.reportDetails?.patient;
    final report = viewModel.reportDetails?.report;
    final billInformations = report?.billInformations ?? {};

    // Calculate total payable and due amounts based on the logic you provided
    final totalPayable = (double.parse(report?.estimatedTotal ?? '0') *
        (1 - (double.parse(report?.discount ?? '0') / 100))).toStringAsFixed(2);
    final dueAmount = (double.parse(report?.estimatedTotal ?? '0') *
        (1 - (double.parse(report?.discount ?? '0') / 100)) -
        double.parse(report?.paidAmount ?? '0')).toStringAsFixed(2);

    // Basic black and white CSS
    final css = """
      <style>
        body {
          font-family: Arial, sans-serif;
          color: #000;
          padding: 20px;
          font-size: 14px;
        }
        h1 {
          text-align: center;
        }
        .section {
          margin-bottom: 20px;
        }
        .section-title {
          font-weight: bold;
          text-decoration: underline;
        }
        table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 10px;
        }
        table, th, td {
          border: 1px solid black;
        }
        th, td {
          padding: 8px;
          text-align: left;
        }
        .total {
          font-weight: bold;
        }
      </style>
    """;

    // HTML content as a string, no need for final keyword since we're appending to it
    String htmlContent = """
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        $css
      </head>
      <body>
        <h1>Patient Bill Report</h1>

        <div class="section">
          <div class="section-title">Patient Information</div>
          <p>Name: ${patient?.name ?? 'N/A'}</p>
          <p>Age: ${patient?.age ?? 'N/A'}</p>
          <p>Gender: ${patient?.gender ?? 'N/A'}</p>
          <p>Phone: ${patient?.phone ?? 'N/A'}</p>
        </div>

        <div class="section">
          <div class="section-title">Report Information</div>
          <p>Report ID: ${report?.reportId ?? 'N/A'}</p>
          <p>Billing Date: ${report?.entryDate ?? 'N/A'}</p>
          <p>Biller Name: ${report?.billerName ?? 'N/A'}</p>
        </div>

        <div class="section">
          <div class="section-title">Test Details</div>
          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Test Name</th>
                <th>Amount</th>
              </tr>
            </thead>
            <tbody>
    """;

    // Append the test rows dynamically based on `billInformations`
    int count = 1;
    billInformations.forEach((testName, amount) {
      htmlContent += """
        <tr>
          <td>$count</td>
          <td>$testName</td>
          <td>$amount</td>
        </tr>
      """;
      count++;
    });

    // Add Grand Total, Discount, Total Payable, Paid Amount, and Due Amount sections
    htmlContent += """
            </tbody>
          </table>
        </div>

        <div class="section">
          <div class="section-title">Summary</div>
          <p>Grand Total: ${report?.estimatedTotal ?? 'N/A'}</p>
          <p>Discount %: ${report?.discount ?? 'N/A'}</p>
          <p>Total Payable: $totalPayable</p>
          <p>Paid Amount: ${report?.paidAmount ?? 'N/A'}</p>
          <p>Due Amount: $dueAmount</p>
        </div>
      </body>
      </html>
    """;

    // Generate the PDF using the HTML content
    final _flutterNativeHtmlToPdfPlugin = FlutterNativeHtmlToPdf();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    const targetFileName = "patient_bill_report";

    final generatedPdfFile = await _flutterNativeHtmlToPdfPlugin.convertHtmlToPdf(
      html: htmlContent,
      targetDirectory: targetPath,
      targetName: targetFileName,
    );

    return generatedPdfFile;
  } catch (e) {
    print("Error generating PDF: $e");
    return null;
  }
}
