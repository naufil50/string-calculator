class StringCalculator
  DEFAULT_DELIMITERS = [",", "\n"]
  MAX_ALLOWED_NUMBER = 1000

  def add(numbers)
    @numbers = numbers
    return 0 if @numbers.empty?

    @delimiters = DEFAULT_DELIMITERS
    final_result
  end

  private

  def numbers_list
    @_numbers_list ||= @numbers.split(delimiters_regex).map(&:to_i).select { |num| num <= MAX_ALLOWED_NUMBER }
  end

  def delimiters_regex
    Regexp.union(@delimiters)
  end

  def final_result
    numbers_list.sum
  end
end
