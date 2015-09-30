defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    number |> prime_factors([])
           |> Enum.uniq
           |> Enum.map((fn (n) ->
             case n do
               3 -> "Pling"
               5 -> "Plang"
               7 -> "Plong"
               _ -> n
             end
           end))
           |> Enum.join("")
  end

  defp prime_factors(number, r) do
    cond do
      number < 3 && length(r) > 0 -> r
      rem(number, 3) != 0 && rem(number, 5) != 0 && rem(number, 7) != 0 -> [number]
      rem(number, 3) == 0 -> prime_factors(div(number, 3), r ++ [3])
      rem(number, 5) == 0 -> prime_factors(div(number, 5), r ++ [5])
      rem(number, 7) == 0 -> prime_factors(div(number, 7), r ++ [7])
    end
  end
end
