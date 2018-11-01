# Captures the validation error message with the CSV row that caused it.

class CsvImportError < StandardError
  attr_reader :row

  def initialize(message, row)
    @row = row

    formatted_row = row.to_h.ai(html: true, plain: true, ruby19_syntax: true)

    super I18n.t 'imports.error_html', message: message, row: formatted_row
  end
end
