defmodule Ledger.JournalEntry do
  alias __MODULE__
  alias Ledger.Credit
  alias Ledger.Debit

  defstruct [
    created_at: nil,
    description: nil,
    items: []
  ]

  @type t :: %JournalEntry{
    created_at: {{integer, integer, integer}, {integer, integer, integer}},
    description: String.t,
    items: list(%Debit{} | %Credit{})
  }

  @spec total(JournalEntry.t) :: %{debit: %Debit{}, credit: %Credit{}}
  def total(%JournalEntry{items: items}) do
    debit = %Debit{amount: Decimal.new(0)}
    credit = %Credit{amount: Decimal.new(0)}

    Enum.reduce(items, %{debit: debit, credit: credit}, fn
      %Debit{amount: amount}, acc -> %{acc | debit: %Debit{ acc.debit | amount: Decimal.add(acc.debit.amount, amount)}}
      %Credit{amount: amount}, acc -> %{acc | credit: %Credit{ acc.credit | amount: Decimal.add(acc.credit.amount, amount)}}
    end)
  end

  @spec balanced?(JournalEntry.t) :: boolean
  def balanced?(journal_entry=%JournalEntry{}) do
    total = total(journal_entry)
    total.credit.amount == total.debit.amount
  end
end
