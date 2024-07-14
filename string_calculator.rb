class StringCalculator
  DEFAULT_DELIMITERS = [",", "\n"]
  MAX_ALLOWED_NUMBER = 1000

  def add(numbers)
    @numbers = numbers
    return 0 if @numbers.empty?

    extract_delimiters_and_numbers
    validate_positive_numbers!
    final_result
  end

  private

  def extract_delimiters_and_numbers
    if @numbers.start_with?("//")
      @delimiters_section, @numbers = @numbers.split("\n", 2)
      @delimiters = extract_delimiters
    else
      @delimiters = DEFAULT_DELIMITERS
    end
  end

  def extract_delimiters
    @delimiters_section.include?("[") ? extract_delimiters : [extract_single_delimiter]
  end

  def extract_single_delimiter
    @delimiters_section[2..-1]
  end

  def extract_delimiters
    @delimiters_section.scan(/\[([^\]]+)\]/).flatten
  end

  def validate_positive_numbers!
    raise negative_numbers_error_text unless negative_numbers.empty?
  end

  def numbers_list
    @_numbers_list ||= @numbers.split(delimiters_regex).map(&:to_i).select { |num| num <= MAX_ALLOWED_NUMBER }
  end

  def negative_numbers
    @_negative_numbers ||= numbers_list.select { |num| num < 0 }
  end

  def delimiters_regex
    Regexp.union(@delimiters)
  end

  def negative_numbers_error_text
    "Negative numbers not allowed: #{negative_numbers.join(', ')}"
  end

  def final_result
    numbers_list.sum
  end
end
