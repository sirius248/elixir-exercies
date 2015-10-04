defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    if count == 0, do: raise("opps"), else: recur(count, 1, 2)
  end

  defp recur(n, base, r) do
    base = if is_prime?(r), do: base+1, else: base
    cond do
      base > n  -> r
      base <= n -> recur(n, base, r+1)
    end
  end

  def factors(1, _), do: [1]
  def factors(_, 1), do: [1]
  def factors(n, i) do
    if rem(n, i) == 0 do
      [i|factors(n, i-1)]
    else
      factors(n, i-1)
    end
  end

  def is_prime?(n) do
    factors(n, div(n, 2)) == [1]
  end
end
