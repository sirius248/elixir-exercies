defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string |> String.reverse
           |> to_char_list
           |> Enum.with_index
           |> Enum.reduce(0, fn (x, acc) ->
                 case elem(x,0) do
                   ?1 -> acc + :math.pow(2, elem(x,1))
                   _  -> acc
                 end
              end)
  end
end
