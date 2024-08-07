defmodule JobProcessor.Job do
  alias JobProcessor.Job.{Parser, Converter}

  @derive Jason.Encoder
  defstruct tasks: []

  def parse(conn), do: Parser.parse(conn)

  def to_script(job), do: Converter.to_script(job)

  def to_json(job), do: Converter.to_json(job)

  def sort_tasks(%JobProcessor.Job{tasks: tasks} = job) do
    %{job | tasks: JobProcessor.Task.sort(tasks)}
  end
end
