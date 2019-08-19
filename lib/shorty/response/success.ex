defmodule Shorty.Response.Success do
  @moduledoc """
  Success struct
  {
    success: true,
    errors: null,
    data: {}
  }
  """

  @behaviour Access
  defstruct success: true, errors: nil, data: %{}

  def fetch(term, key), do: Map.fetch(term, key)

  def get_and_update(data, key, func), do: Map.get_and_update(data, key, func)

  def pop(data, key), do: Map.pop(data, key)
end
