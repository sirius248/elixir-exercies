defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    cond do
      length(strand1) != length(strand2) -> nil
      strand1 == strand2 -> 0
      strand1 != strand2 -> count_diff(strand1, strand2, 0)
    end
  end

  def count_diff(strand1, strand2, r) do
    if strand1 == [] do
      r
    else
      [head1|tail1] = strand1
      [head2|tail2] = strand2
      count_diff(tail1, tail2, (if head1 != head2, do: r + 1, else: r ))
    end
  end
end
