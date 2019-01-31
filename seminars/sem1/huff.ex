defmodule Huffman do

    #def sample do
        #'the quick brown fox jumps over the lazy dog
        #this is a sample text that we will use when we build
        # up a table we will only handle lower case letters and
        #no punctuation symbols the frequency will of course not
        #represent english but it is probably not that far off'
    #end

    #def text() do
        #'this is something that we should encode'
    #end

    #def test do
        #sample = sample()
        #tree = tree(sample)
    #end

    # Sets the frequency of the letters and sorts the frequency.
    def tree(sample) do
        freq = freq(sample)
        freq = isort(freq)
        huffman(freq)
    end

    def freq(sample) do
        freq(sample, [])
    end

    def freq([], freq) do freq end

    def freq([char | rest], freq) do
        freq(rest, add_freq(char, freq))
    end

    # Adds the frequency to each letter.
    def add_freq(char, []) do
        [{1, char}]
    end

    def add_freq(char, [{f, char} | tail]) do
        [{f+1, char} | tail]
    end

    def add_freq(char, [head | tail]) do
        [head | add_freq(char, tail)]
    end

    # Sorting and inserting the frequency in correct order
    def isort(list) do isort(list, []) end
    def isort([], sorted) do sorted end
    def isort([head | tail], sorted) do
        isort(tail, insert(head, sorted))
    end

    def insert(f, []) do [f] end
    def insert({f1, c1}, [{f2, c2} | tail]) when f1 <= f2 do
        [{f1, c1}, {f2, c2} | tail]
    end
    def insert({f1, c1}, [{f2, c2} | tail]) when f1 > f2 do
        [{f2, c2} | insert({f1, c1}, tail)]
    end

    # Huffman tree
    # Going through the frequency list and take the first two nodes, add them together.
    def huffman([x]) do
        [x]
    end
    def huffman([{f1, c1}, {f2, c2} | tail]) do
        huffman(insert_tree({f1+f2, {c1, c2}}, tail))
    end

    # Insert into the sorted list.
    def insert_tree(n, []) do
        [n]
    end
    def insert_tree({f, tup}, [{f2, tup2}|t]) when f <= f2 do
        [{f, tup}, {f2, tup2} | t]
    end
    def insert_tree({f, tup}, [{f2, tup2}|t]) when f > f2 do
        [{f2, tup2} | insert({f, tup}, t)]
    end
end