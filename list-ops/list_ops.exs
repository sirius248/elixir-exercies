defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    case l do
      [] -> 0
      [head | tail]  -> 1 + count(tail)
    end
  end

  @spec reverse(list) :: list
  def reverse(l) do
    case l do
      [] -> []
      _ -> reverse_iter(l, [])
    end
  end

  def reverse_iter(l, r) do
    case l do
      [] -> r
      [head |tail] -> reverse_iter(tail, [head | r])
    end
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    case l do
      [] -> []
      [head | tail] -> [ f.(head) | map(tail, f) ]
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    case l do
      [] -> []
      [head | tail] ->
        if f.(head) do
          [head | filter(tail, f)]
        else
          filter(tail, f)
        end
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    case l do
      [] -> acc
      [head | tail] -> reduce(tail, f.(head, acc), f)
    end
  end

  @spec append(list, list) :: list
  def append(a, b) do
    case a do
      [] -> b
      [ head | tail ] -> [ head | append(tail , b) ]
    end
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    case ll do
      [] -> []
      [head | tail] -> append(head, concat(tail))
    end
  end
end
