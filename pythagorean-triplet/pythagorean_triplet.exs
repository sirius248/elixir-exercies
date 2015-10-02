defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet) do
    triplet |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet) do
    triplet |> Enum.reduce(1, fn(x, acc) -> x * acc end)
  end

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    if (a*a + b*b) == (c*c), do: true, else: false
  end

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max) do
    (for x <- (min..max),
        y <- (min..max),
        :math.sqrt(x*x + y*y) <= max,
        perfect_root(:math.sqrt(x*x + y*y)),
        pythagorean?([x, y, :math.sqrt(x*x + y*y)]), do: [x, y, :math.sqrt(x*x + y*y)] |> Enum.sort) |> Enum.uniq
  end

  defp perfect_root(f) do
    (f |> to_string |> String.contains?("e")) || ((f |> to_string |> Integer.parse |> elem(1)) == ".0")
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    generate(min, max) |> Enum.filter(fn(x) -> sum(x) == sum end) 
  end
end
