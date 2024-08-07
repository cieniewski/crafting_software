defmodule JobProcessor.Job.Converter do
  @script_header "#!/usr/bin/env bash\n"

  def to_script(%JobProcessor.Job{tasks: tasks}) do
    commands = Enum.map(tasks, & &1.command) |> Enum.join("\n")
    @script_header <> commands <> "\n"
  end

  def to_json(%JobProcessor.Job{} = job) do
    Jason.encode!(job)
  end
end
