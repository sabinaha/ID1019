defmodule ListOp do
    # Returns the n'th element of the list
    def nth(0, [head | _tail]) do head end
    def nth(n, [_head | tail]) do
        nth(n - 1, tail)
    end

    # Returns the number of elements in the list.
    def len([]) do 0 end
    def len([_head | tail]) do
        1 + len(tail)
    end

    # Returns the sum of all the elements in the list.
    def sum([]) do 0 end
    def sum([head | tail]) do
        head + sum(tail)
    end

    # Returns a list where all elements are duplicated
    def duplicate([]) do [] end
    def duplicate ([head | tail]) do
        [head, head | duplicate(tail)]
    end

    # Add the element x to the list if it is not in the list
    def add(x, []) do [x] end
    def add(x, [x | tail]) do [x | tail] end
    def add(x, [head | tail]) do [head | add(x, tail)] end

    # Remove all occurrences of x in the list
    def remove(_, []) do [] end
    def remove(x, [x | tail]) do remove(x, tail) end
    def remove(x, [head | tail]) do
        [head | remove(x, tail)]
    end

    # Return a list of unique elements in the list
    def unique([]) do [] end
    def unique([x | tail]) do
        [x | unique(remove(x, tail))]
    end

    # Returns a list containing lists of equal elements
    def pack([]) do [] end
    def pack([x | tail]) do
        {all, rest} = match(x, tail, [x], [])
        [all | pack(rest)]
      end

    # Returns a list of all matching instances
    def match(_, [], all, rest) do {all, rest} end
    def match(x, [x | tail], all, rest) do
        match(x, tail, [x | all], rest)
    end
    def match(x, [y | tail], all, rest) do
        match(x, tail, all, [y | rest])
    end

    # Return a list where the order of elements is reversed
    def naive_reverse([]) do [] end
    def naive_reverse([head | tail]) do
        naive_reverse(tail) ++ [head]
    end
end