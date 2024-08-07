defmodule JobProcessor.HttpServer do
  use Plug.Router

  alias JobProcessor.Job

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  post "/jobs" do
    job =
      conn
      |> Job.parse()
      |> Job.sort_tasks()

    case get_req_header(conn, "accept") do
      ["text/x-shellscript"] ->
        conn
        |> put_resp_content_type("text/x-shellscript")
        |> send_resp(200, Job.to_script(job))

      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Job.to_json(job))
    end
  end
end
