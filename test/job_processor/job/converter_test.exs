defmodule JobProcessor.Job.ConverterTest do
  use ExUnit.Case, async: true
  alias JobProcessor.Job.Converter
  alias JobProcessor.Task

  test "converts a job to a script" do
    job = %JobProcessor.Job{
      tasks: [
        %Task{name: "task1", command: "echo 'task1'"},
        %Task{name: "task2", command: "echo 'task2'"}
      ]
    }

    assert Converter.to_script(job) == """
           #!/usr/bin/env bash
           echo 'task1'
           echo 'task2'
           """
  end

  test "converts a job to json" do
    job = %JobProcessor.Job{
      tasks: [
        %Task{name: "task1", command: "echo 'task1'"},
        %Task{name: "task2", command: "echo 'task2'", requires: ["task1"]}
      ]
    }

    assert Converter.to_json(job) ==
             "{\"tasks\":[{\"command\":\"echo 'task1'\",\"name\":\"task1\",\"requires\":[]},{\"command\":\"echo 'task2'\",\"name\":\"task2\",\"requires\":[\"task1\"]}]}"
  end
end
