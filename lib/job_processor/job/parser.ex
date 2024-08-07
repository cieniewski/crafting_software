defmodule JobProcessor.Job.Parser do
  def parse(%Plug.Conn{body_params: %{"tasks" => tasks}}) do
    %JobProcessor.Job{
      tasks: parse_tasks(tasks)
    }
  end

  defp parse_tasks(tasks) do
    tasks
    |> Enum.map(&parse_task/1)
  end

  defp parse_task(task) do
    %JobProcessor.Task{
      name: task["name"],
      command: task["command"],
      requires: task["requires"] || []
    }
  end
end
