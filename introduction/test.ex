defmodule Test do
    # Compute the double of a number
    def double(n) do
        n * 2
    end

    # Convert fahrenheit to celsius
    def fahrToCel(n) do
        (n - 32)/1.8
    end

    def areaRectangle(n, m) do
        n * m
    end

    def areaSquare(n) do
        areaRectangle(n, n)
    end

    def areaCircle(r) do
        (2*3.1*r*r)/2
    end
end