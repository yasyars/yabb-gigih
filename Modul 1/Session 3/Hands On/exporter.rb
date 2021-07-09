class PdfExporter
  def export
    puts 'Export to .pdf format'
  end
end

class XlsExporter
  def export
    puts 'Export to.xls format'
  end 
end 

class Report
  def initialize(exporter= PdfExporter)
    @exporter = exporter.new
  end

  def generate_monthly_report
    puts "Generating monthly report"
    @export.export
  end
end

pdf_report = Report.new
Pdf_report.generate_monthly_report
xls_report = Report.new(XlsExporter)
xls_report.generate_monthly_report