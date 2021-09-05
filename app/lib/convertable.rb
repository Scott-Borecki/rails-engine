module Convertable
  def convert_to_float(number)
    Float(number)
  rescue ArgumentError
    nil
  end
end
