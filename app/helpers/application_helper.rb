module ApplicationHelper

	# Accepts a string of integers and coverts them to
  # an array of integers
  # E.g., "3 4 5 4 4 5" => [3, 4, 5, 4, 4, 5]
  def get_values(str)
    ret = str.scan(/\d/).map(&:to_i)
  end

  # Sums an array of integers
  def sum_values(arr)
    arr.inject(:+)
  end

  def friendly_date(d)
    d.strftime("%B %e, %Y")
  end
  
end
