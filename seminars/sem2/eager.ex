defmodule Eager do
  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end

  def eval_expr({:const, head, tail}, env) do
    case eval_expr(head, env) do
      :error ->
        :error
      {:ok, head} ->
        case eval_expr(tail, env) do
          :error ->
            :error
          {:ok, tail} ->
            {:ok, {head, tail}}
        end
    end
  end

  def eval_match({:atm, id}, id, env) do {:ok, env} end
  def eval_match({:var, v}, str, env) do 
    case Env.lookup(v, env) do
      nil ->
        {:ok, Env.add(v, str, env)}
        {_, ^str} ->
          {:ok, env}
        {_, _} ->
          :fail
    end
  end
  def eval_match({:const, lt, rt}, {lstr, rstr}, env) do
    case eval_match(lt, lstr, env) do
      :fail ->
        :fail
      {:ok, env} ->
        eval_match(rt, rstr, env)
    end
  end
  def eval_match(_, _, _) do :fail end

  def eval_match(:ignore, _, env) do {:ok, env} end
  def eval_match({:atm, id}, id, env) do {:ok, env} end

  # Returns a list of all variables in the list without :const, :var or :atm
  def eval_scope(pattern, env) do
    Env.remove(extract_vars(pattern), env)
  end

  # Removes :const, :var or :atm from the environment
  def extract_vars(pattern) do
    extract_vars(pattern, [])
  end
  def extract_vars({:atm, _}, vars) do vars end
  def extract_vars(:ignore, vars) do vars end
  def extract_vars({:var, var}, vars) do
    [var | vars]
  end
  def extract_vars({:const, head, tail}, vars) do
    extract_vars(tail, extract_vars(head, vars))
  end

  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end

  def eval_seq([{:match, pattern, expression} | seq], env) do
    case eval_expr(expression, env) do
      :error ->
        :error
      {:ok, str} ->
        eval_seq(seq, env)
    end
  end

end