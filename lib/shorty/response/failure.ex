defmodule Shorty.Response.Failure do
  @moduledoc """
  Failure struct
  {
    success: false,
    errors: [],
    data: nil
  }
  """

  @behaviour Access
  defstruct success: false, errors: [], data: nil

  def fetch(term, key), do: Map.fetch(term, key)

  def get_and_update(data, key, func), do: Map.get_and_update(data, key, func)

  def pop(data, key), do: Map.pop(data, key)
end
