defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate(board) do
    recur(board, [], nil)
  end

  defp recur(board, r, prev) do
    case board do
      [] -> r
      [h | t] -> recur(t, r ++ mine_row(h, prev, Enum.at(t, 0)), h)
    end
  end

  defp mine_row(head, prev, next) do
    head = head |> String.codepoints
                |> Enum.with_index
                |> Enum.map(fn (x) ->
                    if elem(x,0) == "*" do
                      elem(x,0)
                    else
                      curr_idx = elem(x, 1)
                      prev_idx = curr_idx - 1
                      next_idx = curr_idx + 1

                      pre_count  = count_star(prev, prev_idx) + count_star(prev, curr_idx) + count_star(prev, next_idx)
                      nxt_count  = count_star(next, prev_idx) + count_star(next, curr_idx) + count_star(next, next_idx)
                      curr_count = pre_count + nxt_count + count_star(head, prev_idx) + count_star(head, next_idx)

                      if curr_count > 0, do: curr_count, else: elem(x,0)
                    end
                  end)
                |> Enum.join("")

    [head]
  end

  defp count_star(str, idx) do
    if str && idx >= 0 && String.at(str, idx) == "*", do: 1, else: 0
  end

end
