defmodule JobProcessor.Task.SorterTest do
  use ExUnit.Case, async: true
  alias JobProcessor.Task.Sorter

  test "sorts the example from challenge" do
    assert Sorter.sort([
             %JobProcessor.Task{name: "task-1", command: "touch /tmp/file1", requires: []},
             %JobProcessor.Task{
               name: "task-2",
               command: "cat /tmp/file1",
               requires: ["task-3"]
             },
             %JobProcessor.Task{
               name: "task-3",
               command: "echo 'Hello World!' > /tmp/file1",
               requires: ["task-1"]
             },
             %JobProcessor.Task{
               name: "task-4",
               command: "rm /tmp/file1",
               requires: ["task-2", "task-3"]
             }
           ]) == [
             %JobProcessor.Task{name: "task-1", command: "touch /tmp/file1", requires: []},
             %JobProcessor.Task{
               name: "task-3",
               command: "echo 'Hello World!' > /tmp/file1",
               requires: ["task-1"]
             },
             %JobProcessor.Task{name: "task-2", command: "cat /tmp/file1", requires: ["task-3"]},
             %JobProcessor.Task{
               name: "task-4",
               command: "rm /tmp/file1",
               requires: ["task-2", "task-3"]
             }
           ]
  end

  test "does not change order of sorted list" do
    assert Sorter.sort([
             %JobProcessor.Task{name: "task-1", command: "", requires: []},
             %JobProcessor.Task{
               name: "task-2",
               command: "",
               requires: []
             },
             %JobProcessor.Task{
               name: "task-3",
               command: "",
               requires: ["task-2"]
             },
             %JobProcessor.Task{
               name: "task-4",
               command: "",
               requires: ["task-2", "task-3"]
             }
           ]) == [
             %JobProcessor.Task{name: "task-1", command: "", requires: []},
             %JobProcessor.Task{
               name: "task-2",
               command: "",
               requires: []
             },
             %JobProcessor.Task{
               name: "task-3",
               command: "",
               requires: ["task-2"]
             },
             %JobProcessor.Task{
               name: "task-4",
               command: "",
               requires: ["task-2", "task-3"]
             }
           ]
  end

  test "works with empty list" do
    assert Sorter.sort([]) == []
  end
end
