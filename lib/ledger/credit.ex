defmodule Ledger.Credit do
  alias __MODULE__

  defstruct [
    amount: nil
  ]

  @type t :: %Credit{
    amount: Decimal.t
  }
end
