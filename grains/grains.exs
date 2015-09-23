defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    square_iter(number, 1)
  end
  defp square_iter(n, result) do
    case n do
      1 -> result
      _ -> square_iter(n - 1, result * 2)
    end
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    (1..64) |> Enum.reduce(0, fn(x, acc) -> square(x) + acc end)
  end
end
