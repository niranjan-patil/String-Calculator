class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    delimiter = /,|\n/  # default delimiters

    if numbers.start_with?("//")
      parts = numbers.split("\n", 2)
      delimiter = Regexp.escape(parts[0][2..])
      numbers = parts[1]
    end

    nums = numbers.split(/#{delimiter}/).map(&:to_i)

    negatives = nums.select { |n| n < 0 }
    unless negatives.empty?
      raise ArgumentError, "negatives not allowed: #{negatives.join(', ')}"
    end

    nums.sum
  end
end
