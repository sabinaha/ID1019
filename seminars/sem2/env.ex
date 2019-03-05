defmodule Env do

  # Return an empty environment
  def new() do [] end

  # Return an environment where the binding of the variable id
  # to the structure id has been added to the enivironment env
  def add(id, str, []) do
    [{id, str}]
  end
  def add(id, str, [{id_env, str_env}]) do
    [{id_env, str_env}, {id, str}]
  end
  def add(id, str, [_ | t]) do
    add(id, str, t)
  end

  # Returns either {id, str}, if the variable id was bound, or nil
  def lookup(_, []) do nil end
  def lookup(id, [{id, str}]) do {id, str} end
  def lookup(id, [{id, str} | _]) do {id, str} end
  def lookup(id, [_ | t]) do
    lookup(id, t)
  end

  # Returns an environment where all bindings for variables in
  # the list ids has been removed
  def remove([], env) do env end
  def remove([id | ids], env) do
    remove(ids, sub_remove(id, env))
  end

  def sub_remove(_, []) do [] end
  def sub_remove(id, [{id, _} | t]) do
    t
  end
  def sub_remove(id, [h | t]) do
    [h | sub_remove(id, t)]
  end
end