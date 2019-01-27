require 'csv'

class TransactionsImportService
  REQ_H = Transaction::REQUIRED_ATTRS

  attr_reader :imported_count, :total_count

  def initialize(filename, profile_id)
    @filename = filename
    @profile_id = profile_id
    @csv = CSV.table(@filename, headers: true)
    @imported_count = 0
    @total_count = @csv.size
    @errors = []
    @errors << ArgumentError.new(argument_error_message) unless valid_headers?
  end

  def create_many
    raise ArgumentError if imported_count > 0
    @csv.each_with_index do |row, num|
      create(row, num)
    end
  end

  def error_messages
    @errors.join(', ')
  end

  def valid_file?
    @errors.empty?
  end

  private

  def argument_error_message
    <<ERROR
    
      Invalid CSV headers for #{@filename}.
      Required headers: #{REQ_H}
      File contained: #{@csv.headers}
ERROR
  end

  def create(row, num)
    attrs = {
      amount: row[:amount],
      date: Date::strptime(row[:date], '%m/%d/%y'),
      description: row[:description],
      profile_id: @profile_id
    }

    @imported_count += 1
    tranx = Transaction.new(attrs)
    unless tranx.valid? && tranx.save!
      @imported_count -= 1
      @errors << "Line #{num}: #{tranx.errors.full_messages}"
    end
  end

  def valid_headers?
    required_headers_present = true
    REQ_H.each do |rh|
      required_headers_present = false unless @csv.headers.include?(rh)
    end
    required_headers_present
  end
end
