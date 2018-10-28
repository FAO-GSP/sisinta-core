# Captures the validation error message with the CSV row that caused it.

class CsvImportError < StandardError
  attr_reader :row

  def initialize(message, row)
    @row = row

    super I18n.t 'imports.error', message: message, row: row
  end
end
