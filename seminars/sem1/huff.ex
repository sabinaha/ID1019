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

    def tree(sample) do
        freq = freq(sample)
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

    # Huffman tree
    def huffman([]) do {} end
end