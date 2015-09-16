defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, fn (x) ->
                              (string_transform(x) == string_transform(base)) &&
                              (String.downcase(x) != String.downcase(base))
                            end
                )
  end

  def string_transform(str) do
    str |> String.downcase
        |> String.split("")
        |> Enum.sort
        |> Enum.join
  end
end
