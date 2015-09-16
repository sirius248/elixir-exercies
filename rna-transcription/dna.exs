defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn(x) ->
      case x do
        ?G -> 'C'
        ?C -> 'G'
        ?T -> 'A'
        _ -> 'U'
      end
    end
    ) |> Enum.join("") |> to_char_list
  end
end
