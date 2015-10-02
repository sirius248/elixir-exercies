defmodule Series do

  @doc """
  Splits up the given string of numbers into an array of integers.
  """
  @spec digits(String.t) :: [non_neg_integer]
  def digits(number_string) do
    number_string |> String.codepoints
                  |> Enum.map(&(elem(Integer.parse(&1), 0)))
  end

  @doc """
  Generates sublists of a given size from a given string of numbers.
  """
  @spec slices(String.t, non_neg_integer) :: [list(non_neg_integer)]
  def slices(number_string, size) do
    guard = String.length(number_string) - size

    list = number_string |> digits |> Enum.with_index

    list |> Enum.map(fn(x) ->
              if elem(x, 1) <=  guard do
                [elem(x, 0)] ++ ((1..(size-1)) |> Enum.map(fn (y) ->
                    elem(Enum.at(list, elem(x, 1) + y), 0)
                  end))
              end
            end)
         |> Enum.take(guard+1)
  end

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    if size == 0 do
      1
    else
      number_string |> slices(size)
                    |> Enum.map(fn(x) ->
                      x |> Enum.reduce(1, fn(y, acc) -> y * acc end)
                    end)
                    |> Enum.max
    end
  end
end
