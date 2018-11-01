# Captures the validation error message with the CSV row that caused it.

class CsvImportError < StandardError
  attr_reader :row

  def initialize(message, row)
    @row = row

    super I18n.t 'imports.error_html', message: message, row: row.to_h.ai(html: true)
  end
end
