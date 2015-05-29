defmodule Ledger.Debit do
  alias __MODULE__

  defstruct [
    amount: nil
  ]

  @type t :: %Debit{
    amount: Decimal.t
  }
end
