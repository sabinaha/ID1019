defmodule Binary do
    def to_binary(0) do [0] end
    def to_binary(1) do [1] end
    def to_binary(n) do
        to_binary(div(n, 2)) ++ [rem(n,2)]
    end

    def to_better(n) do to_better(n, []) end
    def to_better(0, b) do b end
    def to_better(n, b) do
        to_better(div(n, 2), [rem(n, 2) | b])
    end
end