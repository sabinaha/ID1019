defmodule Recursive do
    def product(m, n) do
        if m == 0 do
            0
        else
            n + product(m - 1, n)
        end
    end

    def product_case(m, n) do
        case m do
            0 ->
                0
            _ ->
                n + product_case(m - 1, n)
        end
    end

    def product_cond(m, n) do
        cond do
            m == 0 ->
                0
            true ->
                n + product_cond(m - 1, n)
            end
    end

    def product_clauses(0, _) do 0 end
    def product_clauses(m, n) do
        n + product_clauses(m - 1, n)
    end

    def exp(x, n) do
        case n do
            0 ->
                1
            1 ->
                x
            _ ->
                exp(product(x,x), n - 1)
        end
    end

    def exp_fast(_, 0) do 1 end
    def exp_fast(x, n) do
        case rem(n, 2) do
            0 ->
                e = exp_fast(x, div(n, 2))
                e * e
            1 ->
                x * exp_fast(x, n - 1)
        end
    end
end