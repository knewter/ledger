defmodule Ledger.Account do
  alias Ledger.Debit
  alias Ledger.Credit
  alias __MODULE__

  defstruct [
    type: nil,
    debits: [],
    credits: []
  ]

  @typedoc """
  An account can be either `:credit` or `:debit`.
  """
  @type account_type :: :credit | :debit

  @typedoc """
  A Ledger Account has a `type`, a list of `credits`, and a list of `debits`.
  """
  @type t :: %Account{
    type: account_type,
    debits: list(Debit.t),
    credits: list(Credit.t)
  }

  def debit(account=%Account{debits: debits}, amount) do
    %Account{account | debits: [%Debit{amount: amount}]}
  end

  def credit(account=%Account{credits: credits}, amount) do
    %Account{account | credits: [%Credit{amount: amount}]}
  end

  def debits_sum(account=%Account{debits: debits}) do
    Enum.reduce(debits, Decimal.new(0), fn(x, acc) ->
      Decimal.add(x.amount, acc)
    end)
  end

  def credits_sum(account=%Account{credits: credits}) do
    Enum.reduce(credits, Decimal.new(0), fn(x, acc) ->
      Decimal.add(x.amount, acc)
    end)
  end
end
