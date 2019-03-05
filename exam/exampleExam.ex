defmodule ExamQ do
  # Double all the even values in a list
  def doubleEven([]) do [] end
  def doubleEven([head | tail]) do
    case rem(head, 2) do
      0 ->
        [head, head | doubleEven(tail)]
      _ ->
        [head | doubleEven(tail)]
    end
  end

  # Returns the sum of all the values in a tree
  def sum(nil) do 0 end
  def sum({:node, value, left, right}) do
    value + sum(left) + sum(right)
  end
end