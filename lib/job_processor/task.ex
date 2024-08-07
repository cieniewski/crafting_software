defmodule JobProcessor.Task do
  alias JobProcessor.Task.Sorter
  @derive Jason.Encoder
  @enforce_keys [:name, :command]
  defstruct [:name, :command, requires: []]

  def sort(tasks) do
    Sorter.sort(tasks)
  end
end
