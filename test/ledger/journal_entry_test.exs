defmodule Ledger.JournalEntryTest do
  use ExUnit.Case
  alias Ledger.JournalEntry
  alias Ledger.Debit
  alias Ledger.Credit

  @debit_entry %Debit{amount: Decimal.new(5)}
  @credit_entry %Credit{amount: Decimal.new(5)}

  test "Borrow Cash" do
    entry = %JournalEntry{
      created_at: {{2014, 07, 31}, {0, 0, 0}},
      description: "Borrowed money from Sam",
      items: [
        @debit_entry,
        @credit_entry
      ]
    }
    assert %Debit{amount: Decimal.new(5)} == JournalEntry.total(entry).debit
    assert %Credit{amount: Decimal.new(5)} == JournalEntry.total(entry).credit
  end

  test "balanced?" do
    balanced_entry = %JournalEntry{
      items: [
        @debit_entry,
        @credit_entry
      ]
    }
    unbalanced_entry = %JournalEntry{
      items: [
        @debit_entry
      ]
    }

    assert JournalEntry.balanced?(balanced_entry)
    refute JournalEntry.balanced?(unbalanced_entry)
  end
end
