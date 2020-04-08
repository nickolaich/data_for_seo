defmodule DataForSeo.Parser do
  @moduledoc """
  A parser built on top of Spect for decoding DataForSEO's various return
  structures.

  https://github.com/pylon/spect
  """

  alias DataForSeo.Serp.Response, as: BaseResponse
  alias DataForSeo.Serp.GetTask.Response, as: GetTaskResponse

  def parse(%Mojito.Response{body: body, status_code: code}, strategy) do
    case code do
      _ ->
        body = Jason.decode!(body)
        parse(body, strategy)
    end
  end

  def parse(body, :task_post) do
    body
    |> Spect.to_spec!(BaseResponse)
  end

  def parse(body, :task_result) do
    body
    |> convert_values(:task_result)
    |> Spect.to_spec!(GetTaskResponse)
  end

  def parse(body, :tasks_ready) do
    body
    |> convert_values(:tasks_ready)
    |> Spect.to_spec!(BaseResponse)
  end

  def parse(resp, _) do
    resp
  end

  defp convert_values(body, :tasks_ready) do
    case get_in(body, ["tasks", Access.all(), "result"]) do
      [nil] ->
        body

      _ ->
        body
        |> update_in(
          ["tasks", Access.all(), "result", Access.all(), "date_posted"],
          &String.replace_suffix(&1, " +00:00", "Z")
        )
    end
  end

  defp convert_values(body, :task_result) do
    case get_in(body, ["tasks", Access.all(), "result"]) do
      [nil] ->
        body

      _ ->
        body
        |> update_in(
          ["tasks", Access.all(), "result", Access.all(), "datetime"],
          &String.replace_suffix(&1, " +00:00", "Z")
        )
    end
  end
end
