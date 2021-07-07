require_relative 'exporter'

class Report
  def initialize(exporter)
    @exporter = exporter
  end 

  def generate_monthly_report
    puts 'Generating monthly report'
    @exporter.export
  end
end

# puts 'Give me PDF report!'
# pdf_report = Report.new(PdfExporter.new)
# pdf_report.generate_monthly_report

# puts 'Give me XLS report!'
# xls_report = Report.new(XlsExporter.new)
# xls_report.generate_monthly_report

pdf_exporter = PdfExporter.new
xls_report = XlsExporter.new

xls_report = pdf_exporter

pol = GenericExporter.new
# pol = xls_report
pol.export
# xls_report.export