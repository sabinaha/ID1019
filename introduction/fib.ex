defmodule Fib do
    def bench_fib() do
        ls = [8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32]
        n = 10

        bench = fn(l) ->
            t = time(n, fn() -> fib(l) end)
            :io.format("n: ~4w fib(n) calculated in: ~8w us~n", [l, t])
        end
        Enum.each(ls, bench)
    end

    def time(n, fun) do
        start = System.monotonic_time(:millisecond)
        loop(n, fun)
        stop = System.monotonic_time(:millisecond)
        stop - start
    end

    def loop(n, fun) do
        if n == 0 do
            :ok
        else
            fun.()
            loop(n - 1, fun)
        end
    end

    def fib(0) do 0 end
    def fib(1) do 1 end
    def fib(2) do 1 end
    def fib(n) do
        fib(n - 2) + fib(n - 1)
    end
end