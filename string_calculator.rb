class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    delimiter_regex, body = parse_delimiters(numbers)

    nums = body.split(delimiter_regex).map(&:to_i)

    check_for_negatives!(nums)

    nums.reject { |n| n > 1000 }.sum
  end

  private

  def self.parse_delimiters(numbers)
    if numbers.start_with?("//")
      header, body = numbers.split("\n", 2)

      if header.include?("[")
        delims = header.scan(/\[(.*?)\]/).flatten
        regex  = Regexp.union(delims.map { |d| Regexp.new(Regexp.escape(d)) })
      else
        regex  = Regexp.new(Regexp.escape(header[2..]))
      end

      [regex, body]
    else
      [/[,|\n]/, numbers]
    end
  end

  def self.check_for_negatives!(nums)
    negatives = nums.select { |n| n < 0 }
    unless negatives.empty?
      raise ArgumentError, "Negative numbers not allowed: #{negatives.join(', ')}"
    end
  end
end
