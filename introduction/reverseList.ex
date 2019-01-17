defmodule Reverse do
    def nreverse([]) do [] end
    def nreverse([head | tail]) do
        r = nreverse(tail)
        append(r, [head])
    end

    def append(r, h) do
        case h do
            [] -> [r]
            [x] -> [r | x]
            [head | tail] -> [r | head | tail]
        end
    end
end