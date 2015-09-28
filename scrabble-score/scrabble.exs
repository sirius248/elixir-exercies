defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word |> String.upcase
         |> to_char_list
         |> Enum.reduce(0, fn (x, acc) -> char_to_point(x) + acc end)
  end

  defp char_to_point(ch) do
    cond do
      Enum.member?([?A, ?E, ?I, ?O, ?U, ?L, ?N, ?R, ?S, ?T], ch) -> 1
      Enum.member?([?D, ?G], ch)                                 -> 2
      Enum.member?([?B, ?C, ?M, ?P], ch)                         -> 3
      Enum.member?([?F, ?H, ?V, ?W, ?Y], ch)                     -> 4
      Enum.member?([?K], ch)                                     -> 5
      Enum.member?([?J, ?X], ch)                                 -> 8
      Enum.member?([?Q, ?Z], ch)                                 -> 10
      Enum.member?([?\t, ?\n, ?\ ], ch)                          -> 0
    end
  end
end
