defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.

  Allergies should be ordered, starting with the allergie with the least
  significant bit ("eggs").
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    flags |> list_builder(HashSet.new)
  end

  defp list_builder(item, r) do
    cond do
      item < 1 -> r
      item >= 128 -> list_builder(item - 128, HashSet.put(r, "cats"))
      item >= 64 -> list_builder(item - 64, HashSet.put(r, "pollen"))
      item >= 32 -> list_builder(item - 32, HashSet.put(r, "chocolate"))
      item >= 16 -> list_builder(item - 16, HashSet.put(r, "tomatoes"))
      item >= 8 -> list_builder(item - 8, HashSet.put(r, "strawberries"))
      item >= 4 -> list_builder(item - 4, HashSet.put(r, "shellfish"))
      item >= 2 -> list_builder(item - 2, HashSet.put(r, "peanuts"))
      item >= 1 -> list_builder(item - 1, HashSet.put(r, "eggs"))
    end
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    flags |> list_builder(HashSet.new)
          |> HashSet.member?(item)
  end
end
