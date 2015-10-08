defmodule Forth do
  @opaque evaluator :: any

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    []
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t) :: evaluator
  def eval(ev, s) do
    if s |> String.at(0) == ":" do
      s = s |> String.split(" ")

      if is_int?(Enum.at(s,1)), do: raise Forth.InvalidWord

      if !is_odd_char?(Enum.at(s,1)) do
        ev = { Enum.at(s,1) ,(s |> Enum.slice(2..(Enum.count(s) -2)) |> Enum.join(" ")) }
      else
        ev = [(s |> Enum.slice(2..(Enum.count(s) -3)) |> Enum.join(" "))]
      end
      ev
    else
      if ev != [] && String.contains?(s, elem(ev,0)) do
        s = s |> String.replace(~r/(#{elem(ev,0)})/, "#{elem(ev, 1)}")
      end

      cond do
        s |> String.contains?(" ") -> s = s |> String.codepoints |> Enum.filter(&(is_int?(&1) || is_op?(&1)))
        !(s |> String.contains?(" ")) -> s = s |> String.downcase |> String.split(" ")
      end

      if (s |> Enum.all?(&is_int?/1)) do
        s
      else
        eval_stack([], s, [])
      end
    end
  end

  defp eval_stack(stack, list, r) do
    case list do
      [] -> r
      [h | t] -> cond do
                   is_int?(h) -> eval_stack(stack ++ [h], t, r)
                   h == "dup" -> if Enum.any?(stack), do: eval_stack(stack ++ [take_1_last(stack)], t, stack ++ [take_1_last(stack)]), else: raise Forth.StackUnderflow
                   is_op?(h)  -> eval_stack(drop_last(stack) ++ [ process(take_first(stack), h) ], t, [ process(stack, h )] )
                   !is_op?(h) -> raise Forth.UnknownWord
                 end
    end
  end

  defp take_1_last(list) do
    list |> Enum.reverse |> Enum.take(1)
  end

  defp drop_last(list) do
    list |> Enum.reverse |> Enum.drop(2)
  end

  defp take_first(list) do
    list |> Enum.reverse |> Enum.take(2)
  end

  defp process(stack, op) do
    vals = Enum.take(stack, 2)
    op = String.downcase(op)
    if vals |> Enum.at(0), do: n1 = vals |> Enum.at(0) |> Integer.parse |> elem(0), else: n1 = nil
    if vals |> Enum.at(1), do: n2 = vals |> Enum.at(1) |> Integer.parse |> elem(0), else: n2 = nil
    if stack |> Enum.at(2), do: n3 = stack |> Enum.at(2) |> Integer.parse |> elem(0), else: n3 = nil

    case op do
      "+" -> (n1 + n2) |> to_string
      "-" -> (n1 - n2) |> to_string
      "*" -> (n1 * n2) |> to_string

      "/" -> cond do
         n2 == 0 -> raise Forth.DivisionByZero
         n2 > 0  -> (n1 / n2) |> to_string |> Integer.parse |> elem(0) |> to_string
      end

      "drop" -> cond do
        is_nil(n1) && is_nil(n2)   -> raise Forth.StackUnderflow
        !is_nil(n1) && is_nil(n2)  -> ""
        !is_nil(n1) && !is_nil(n2) -> "#{n1}"
      end

      "swap" -> cond do
        is_nil(n1) && is_nil(n2)    -> raise Forth.StackUnderflow
        !is_nil(n1) && is_nil(n2)   -> raise Forth.StackUnderflow
        !is_nil(n1) && !is_nil(n2) && !is_nil(n3)  -> "#{n1} #{n3} #{n2}"
        !is_nil(n1) && !is_nil(n2) && is_nil(n3) -> "#{n2} #{n1}"
      end

      "over" -> cond do
        is_nil(n1) && is_nil(n2)    -> raise Forth.StackUnderflow
        !is_nil(n1) && is_nil(n2)   -> raise Forth.StackUnderflow
        !is_nil(n1) && !is_nil(n2) && !is_nil(n3)  -> "#{n1} #{n2} #{n3} #{n2}"
        !is_nil(n1) && !is_nil(n2) && is_nil(n3) -> "#{n1} #{n2} #{n1}"
      end
    end
  end

  defp is_int?(s) do
    Enum.member?(["1", "2", "3", "4", "5", "6", "7", "8", "9"], String.downcase(s))
  end

  defp is_op?(s) do
    Enum.member?(["+", "-", "*", "/", "dup", "drop", "swap", "over"], String.downcase(s))
  end

  defp is_odd_char?(s) do
    Enum.member?(["€"], String.downcase(s))
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t
  def format_stack(ev) do
    ev |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception message: "stack underflow"
  end

  defmodule InvalidWord do
    defexception [:word]
    def message(e), do: "invalid word: #{inspect e.word}"
  end

  defmodule UnknownWord do
    defexception [:word]
    def message(e), do: "unknown word: #{inspect e.word}"
  end

  defmodule DivisionByZero do
    defexception message: "division by zero"
  end
end
