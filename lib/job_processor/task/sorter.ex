defmodule JobProcessor.Task.Sorter do
  @moduledoc """
  Sorts tasks based on their dependencies.
  Does not support circular dependencies.
  """

  def sort(tasks) do
    sort(tasks, [], [])
  end

  defp sort([], sorted, []) do
    sorted
  end

  defp sort([], sorted, visited) do
    sort(visited, sorted, [])
  end

  defp sort(unsorted, sorted, visited) do
    [first_unsorted | rest_unsorted] = unsorted

    sorted_names = sorted |> Enum.map(& &1.name)

    if(Enum.all?(first_unsorted.requires, &(&1 in sorted_names))) do
      # All required tasks are in sorted list, or no required tasks
      sort(rest_unsorted, sorted ++ [first_unsorted], visited)
    else
      # Some required tasks are not in sorted list
      sort(rest_unsorted, sorted, visited ++ [first_unsorted])
    end
  end
end
