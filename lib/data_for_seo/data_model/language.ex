defmodule DataForSeo.DataModel.Language do
  use DataForSeo.DataModel.Entity

  @primary_key false
  embedded_schema do
    field(:language_name, :string)
    field(:language_code, :string)
  end
end