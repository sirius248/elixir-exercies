defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    words = sentence |> String.replace(~r/[,:!&@$%^]/, "")
                     |> String.split([" ", "_"])
                     |> Enum.filter(&(&1 != ""))
                     |> Enum.map(&(String.downcase &1))

    for word <- words, into: %{}, do: {word, Enum.count(words, &(&1 == word))}

  end
end
