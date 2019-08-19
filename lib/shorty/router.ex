defmodule Shorty.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug Plug.Logger

  plug :match
  plug Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Poison
  plug :dispatch

  get "/ping" do
    send_resp(conn, 200, "pong!")
  end

  post "/urlx" do
    result = Shorty.Controllers.Urls.create(conn, %{url: conn.body_params["url"]})
    code = case result[:success] do
      true -> 201
      false -> 400
    end

    send_resp(conn, code, result |> Poison.encode!)
  end

  get "/urlx/:id" do
    result = Shorty.Controllers.Urls.show(conn, %{id: conn.params["id"]})
    unless result[:success], do: send_resp(conn, 400, result |> Poison.encode!)

    conn |> redirect(result.data.url)
  end

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end

  defp redirect(conn, url) do
    uri_esc = Plug.HTML.html_escape(url)

    url = cond do
      String.starts_with?(uri_esc, ["http://", "https://"]) -> uri_esc
      String.starts_with?(uri_esc, "//") -> "https:#{uri_esc}"
      true -> "https://#{uri_esc}"
    end

    body = "<html><body>You are being <a href=\"#{url}\">redirected</a>.</body></html>"

    conn
    |> put_resp_header("location", url)
    |> put_resp_content_type("text/html")
    |> send_resp(conn.status || 302, body)
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    conn
    |> send_resp(conn.status, %{success: false, data: "Server error" } |> Poison.encode!)
  end

end
