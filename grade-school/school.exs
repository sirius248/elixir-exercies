defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(Dict.t, String.t, pos_integer) :: Dict.t
  def add(db, name, grade) do
    if Dict.has_key?(db, grade) do
      Dict.put(db, grade, Dict.get(db, grade) ++ [name])
    else
      Dict.put(db, grade, [name])
    end
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(Dict.t, pos_integer) :: [String]
  def grade(db, grade) do
    if Dict.has_key?(db, grade), do: Dict.get(db, grade), else: []
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(Dict) :: Dict.t
  def sort(db) do
    sort_help(db, Dict.keys(db), %{})
  end

  def sort_help(db, keys, r) do
    case keys do
      [] -> r
      [head|tail] -> sort_help(db, tail, Dict.put(r, head, Enum.sort(grade(db, head))))
    end
  end
end
