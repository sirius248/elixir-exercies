defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    [count_a, count_b] = [Enum.count(a), Enum.count(b)]
    cond do
      count_a == count_b -> if a === b, do: :equal, else: :unequal
      count_a > count_b -> list_builder(a, b, count_b, :superlist)
      count_a < count_b -> list_builder(b, a, count_a, :sublist)
    end
  end

  def list_builder(a, b, c, r) do
    if Enum.count(a) >= c do
      next_l    = Enum.drop(a, 1)
      current_l = Enum.take(a, c)
      if current_l === b do
        r
      else
        list_builder(next_l, b, c, r)
      end
    else
      :unequal
    end
  end
end
