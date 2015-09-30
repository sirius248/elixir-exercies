defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    (2..limit) |> Enum.filter(&(is_prime?(&1)))
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
