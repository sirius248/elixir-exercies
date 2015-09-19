defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    transform_helper(input, Dict.keys(input), %{})
  end

  def transform_helper(input, ks, r) do
    case ks do
      [] -> r
      [h|t] -> transform_helper(input, t, Dict.merge(build(Dict.get(input, h), h), r))
    end
  end

  def build(list, k) do
    for i <- list, into: %{}, do: { String.downcase(i), k }
  end
end
