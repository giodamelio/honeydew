defmodule Honeydew.Dispatcher.LRU do
  # TODO: docs

  def init do
    {:ok, :queue.new}
  end

  def available?(free) do
    !:queue.is_empty(free)
  end

  def check_in(worker, free) do
    :queue.in(worker, free)
  end

  def check_out(_job, free) do
    case :queue.out(free) do
      {{:value, worker}, free} ->
        {worker, free}
      {:empty, _free} ->
        {nil, free}
    end
  end

  def remove(worker, free) do
    :queue.filter(&(&1 != worker), free)
  end
end
