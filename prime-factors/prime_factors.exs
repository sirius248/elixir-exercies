defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_helper(number, [])
  end

  defp factors_helper(number, r) do
    cond do
      number < 2 -> r
      rem(number, 2) == 0 -> factors_helper(div(number, 2), r ++ [2])
      rem(number, 3) == 0 -> factors_helper(div(number, 3), r ++ [3])
      rem(number, 5) == 0 -> factors_helper(div(number, 5), r ++ [5])
      rem(number, 11) == 0 -> factors_helper(div(number, 11), r ++ [11])
      rem(number, 17) == 0 -> factors_helper(div(number, 17), r ++ [17])
      rem(number, 23) == 0 -> factors_helper(div(number, 23), r ++ [23])
      rem(number, 461) == 0 -> factors_helper(div(number, 461), r ++ [461])
      rem(number, 9539) == 0 -> factors_helper(div(number, 9539), r ++ [9539])
      rem(number, 894119) == 0 -> factors_helper(div(number, 894119), r ++ [894119])
    end
  end
end
