defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    cond do
      a <= 0 || b <= 0 || c <= 0  -> { :error, "all side lengths must be positive" }
      a == b && b == c            -> { :ok, :equilateral }

      (a == b || a == c || b == c) && valid_triangle?(Enum.sort([a,b,c]))  -> { :ok, :isosceles }
      (a != b || a != c || b != c) && valid_triangle?(Enum.sort([a,b,c]))  -> { :ok, :scalene }
      (a != b || a != c || b != c) && !valid_triangle?(Enum.sort([a,b,c])) -> { :error, "side lengths violate triangle inequality" }
    end
  end

  defp valid_triangle?(l) do
    (Enum.at(l,0) + Enum.at(l,1)) > Enum.at(l,2)
  end
end
