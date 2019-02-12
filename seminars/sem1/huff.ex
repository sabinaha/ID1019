defmodule Huffman do

  def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
         up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
  end

  def text() do
    'this is something that we should encode'
  end

  def test do
    sample = sample()
    text = text()
    tree = tree(sample)
    encode = encode_table(tree)
    seq = encode(text, encode)
    decode = decode_table(tree)
    decode(seq, decode)
  end
  # Construct the Huffman tree from a text sample.
  def tree(sample) do
    freq = freq(sample)
    huffman(freq)
  end

  # Compute the frequencies of all the characters in the
  # sample text and return a list of tuples {char, freq}.
  def freq(sample), do: freq(sample, [])

  def freq([], freq) do freq end
  def freq([char | rest], freq) do
    freq(rest, update(char, freq))
  end

  def update(char, []), do: [{char, 1}]
  def update(char, [{char, n} | freq]) do
    [{char, n + 1} | freq]
  end
  def update(char, [elem | freq]) do
    [elem | update(char, freq)]
  end

  # Build the actual Huffman tree inserting a character at
  # time based on the frequency.
  def huffman(freq) do
    sorted = Enum.sort(freq, fn({_, x}, {_, y}) -> x < y end)
    huffman_tree(sorted)
  end

  def huffman_tree([{tree, _}]) do tree end
  def huffman_tree([{a, af}, {b, bf} | rest]) do
    huffman_tree(insert({{a, b}, af + bf}, rest))
  end

  def insert({a, af}, []) do [{a, af}] end
  def insert({a, af}, [{b, bf} | rest]) when af < bf do
    [{a, af}, {b, bf} | rest]
  end
  def insert({a, af}, [{b, bf} | rest]) do
    [{b, bf} | insert({a, af}, rest)]
  end

  # Build the encoding table.
  def encode_table(tree) do
    codes(tree, [])
    # codes_better(tree, [], [])
  end

  # Traverse the Huffman tree and build a binary encoding
  # for each character.
  def codes({a, b}, sofar) do
    as = codes(a, [0 | sofar])
    bs = codes(b, [1 | sofar])
    as ++ bs
  end
  def codes(a, code) do
    [{a, Enum.reverse(code)}]
  end

  def encode(text, table) do encode(text, table, table) end

  def encode([], _, _) do [] end
  def encode([char | rest], [{char, bin} | _restTable], table) do
    bin ++ encode(rest, table, table)
  end
  def encode(letterList, [_c | tail], table) do
    encode(letterList, tail, table)
  end

  # Decode table
  def decode_table(tree) do codes(tree, []) end

  # Decode text
  def decode([], _) do [] end
  def decode(seq, table) do 
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end
  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest}
      nil ->
        decode_char(seq, n+1, table)
    end
  end
end