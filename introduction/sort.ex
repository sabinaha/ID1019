defmodule ListSort do
    #=====================================
    #=          INSERTION SORT           =
    #=====================================
    def isort(l) do isort(l, []) end
    def isort([], sorted) do sorted end
    def isort([head | tail], sorted) do
        isort(tail, insert(head, sorted))
    end

    def insert(x, []) do [x] end
    def insert(x, [head | tail]) when x < head do
        [x, head | tail]
    end
    def insert(x, [head | tail]) do
        [head | insert(x, tail)]
    end

    #=====================================
    #=            MERGE SORT             =
    #=====================================
    def msort([]) do [] end
    def msort([x]) do [x] end
    def msort(l) do
        {first, second} = msplit(l, [], [])
        merge(msort(first), msort(second))
    end

    def msplit([], first, second) do {first, second} end
    def msplit([head | tail], first, second) do
        msplit(tail, [head | second], first)
    end

    def merge([first], []) do [first] end
    def merge([], [second]) do [second] end
    def merge([fhead | first], [shead | _] = second) when fhead < shead do
        [fhead | merge(first, second)]
    end
    def merge(first, [shead | second]) do
        [shead | merge(first, second)]
    end

    #=====================================
    #=            QUICK SORT             =
    #=====================================
    def qsort([]) do [] end
    def qsort([x]) do [x] end
    def qsort([head | tail]) do
        {l1, l2} = qsplit(head, tail, [], [])
        small = qsort(l1)
        large = qsort(l2)
        append(small, [head | large])
    end

    def qsplit(_, [], small, large) do {small, large} end
    def qsplit(p, [head | tail], small, large) do
        if p > head do
            qsplit(p, tail, [head | small], large)
        else
            qsplit(p, tail, small, [head | large])
        end
    end

    def append(small, large) do
        case small do
          [] -> large
          [h | t] -> [h | append(t, large)]
        end
      end
end