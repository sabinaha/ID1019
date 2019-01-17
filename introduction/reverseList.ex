defmodule Reverse do
    def bench() do
        ls = [16, 32, 64, 128, 256, 512]
        n = 100

        # Bench is a closure: a function with an environment
        bench = fn(l) ->
            seq = Enum.to_list(1..l)
            tn = time(n, fn -> nreverse(seq) end)
            tr = time(n, fn -> reverse(seq) end)
            :io.format("Length: ~10w nrev: ~8w us     rev: ~8w us~n", [l, tn, tr])
        end

        # We use the library function Enum.each that will call
        # bench(l) for each element l in ls
        Enum.each(ls, bench)
    end

    def time(n, fun) do
        start = System.monotonic_time(:millisecond)
        loop(n, fun)
        stop = System.monotonic_time(:millisecond)
        stop - start
    end

    # Apply the function n times
    def loop(n, fun) do
        if n == 0 do
            :ok
        else
            fun.()
            loop(n - 1, fun)
        end
    end

    def nreverse([]) do [] end
    def nreverse([head | tail]) do
        r = nreverse(tail)
        r ++ [head]
    end

    def reverse(l) do
        reverse(l, [])
    end
    def reverse([], r) do r end
    def reverse([head | tail], r) do
        reverse(tail, [head | r])
    end
end