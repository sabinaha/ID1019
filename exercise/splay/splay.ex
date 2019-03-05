defmodule SplayTree do
  # Test to insert in the Splay tree
  def test() do
    insert = [{3, :c}, {5, :e}, {2, :b}, {1, :a}, {7, :g}, {4, :d}, {5, :e}]
    empty = nil
    List.foldl(insert, empty, fn({k, v}, t) -> update(t, k, v) end)
  end

  # If we want to use key-value in an empty tree
  # Returns the updated with the key-value inserted in the tree
  def update(nil, key, value) do
    {:node, key, value, nil, nil}
  end
  # If we want to use key-value in a tree with only one value
  # Returns the tree with the new value for this key
  def update({:node, key, _, a, b}, key, value) do
    {:node, key, value, a, b}
  end
  # When we want to update the splay tree and the key is to the left of
  # the root key value
  def update({:node, rk, rv, zig, c}, key, value) when key < rk do
    # The general rule where we will do the Zig transformation
    {:splay, _, a, b} = splay(zig, key)
    {:node, key, value, a, {:node, rk, rv, b, c}}
  end
  # When we want to update the splay tree and the key is to the right of
  # the root key value
  def update({:node, rk, rv, a, zag}, key, value) when key >= rk do
    {:splay, _, b, c} = splay(zag, key)
    {:node, key, value, {:node, rk, rv, a, b}, c}
  end

  # SPLAY FUNCTION
  # If the tree is empty
  defp splay(nil, _) do
    {:splay, :na, nil, nil}
  end
  # If the tree only contains one value
  defp splay({:node, key, value, a, b}, key) do
    {:splay, value, a, b}
  end
  # When the left sub-tree is empty
  defp splay({:node, rk, rv, nil, b}, key) when key < rk do
    {:splay, :na, nil, {:node, rk, rv, nil, b}}
  end
  # When the right sub-tree is empty
  defp splay({:node, rk, rv, a, nil}, key) when key >= rk do
    {:splay, :na, {:node, rk, rv, a, nil}, nil}
  end
  # When the key is found in the root of the left sub-tree
  defp splay({:node, rk, rv, {:node, key, value, a, b}, c}, key) do
    # Found to the left
    {:splay, value, a, {:node, rk, rv, b, c}}
  end
  # When the key is found in the root of the right sub-tree
  defp splay({:node, rk, rv, a, {:node, key, value, b, c}}, key) do
    # Found to the right
    {:splay, value, {:node, rk, rv, a, b}, c}
  end
  # ZIG-ZIG RULE
  defp splay({:node, gk, gv, {:node, pk, pv, zig_zig, c}, d}, key) when key < gk and key < pk do
    # Going down the left-left, this is the zig-zig case
    {:splay, value, a, b} = splay(zig_zig, key)
    {:splay, value, a, {:node, pk, pv, b, {:node, gk, gv, c, d}}}
  end
  # ZIG-ZAG RULE
  defp splay({:node, gk, gv, {:node, pk, pv, a, zig_zag}, d}, key) when key < gk and key >= pk do
    # Going down the left-right, this is the zig-zag case
    {:splay, value, b, c} = splay(zig_zag, key)
    {:splay, value, {:node, pk, pv, a, b}, {:node, gk, gv, c, d}}
  end
  # ZAG_ZIG RULE
  defp splay({:node, gk, gv, a, {:node, pk, pv, zag_zig, d}}, key) when key >= gk and key < pk do
    {:splay, value, b, c} = splay(zag_zig, key)
    {:splay, value, {:node, gk, gv, a, b}, {:node, pk, pv, c, d}}
  end
  # ZAG_ZAG RULE
  defp splay({:node, gk, gv, a, {:node, pk, pv, b, zag_zag}}, key) when key >= gk and key >= pk do
    {:splay, value, c, d} = splay(zag_zag, key)
    {:splay, value, {:node, pk, pv, {:node, gk, gv, a, b}, c}, d}
  end
end