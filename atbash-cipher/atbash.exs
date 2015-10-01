defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext |> String.replace(~r/[ ,.]/, "")
              |> String.downcase
              |> to_char_list
              |> Enum.map(&(if &1 > 57, do: 219 - &1, else: &1))
              |> helper([])
              |> to_string
              |> String.replace(~r/[,]/, " ")
              |> String.strip
  end

  defp helper(l, r) do
    case l do
      [] -> r
      _ -> helper(Enum.drop(l,5), r ++ ',' ++ Enum.take(l,5))
    end
  end
end
