defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numerals_helper(number, "")
  end

  defp numerals_helper(number, r) do
    cond do
      number >= 1000 -> numerals_helper(number - 1000, r <> "M" )
      number >= 900 -> numerals_helper(number - 900, r <> "CM" )
      number >= 500 -> numerals_helper(number - 500, r <> "D" )
      number >= 400 -> numerals_helper(number - 400, r <> "CD" )
      number >= 100 -> numerals_helper(number - 100, r <> "C" )
      number >= 90 -> numerals_helper(number - 90, r <> "XC" )
      number >= 50 -> numerals_helper(number - 50, r <> "L" )
      number >= 40 -> numerals_helper(number - 40, r <> "XL" )
      number >= 10 -> numerals_helper(number - 10, r <> "X" )
      number >= 9 -> numerals_helper(number - 9, r <> "IX" )
      number >= 5 -> numerals_helper(number - 5, r <> "V" )
      number >= 4 -> numerals_helper(number - 4, r <> "IV" )
      number >= 1 -> numerals_helper(number - 1, r <> "I" )
      number <= 0 -> r
    end
  end
end
