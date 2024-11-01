defmodule DataForSeo.MixProject do
  use Mix.Project

  @source_url "https://github.com/visable-dev/data_for_seo"

  def project do
    [
      app: :data_for_seo,
      version: "0.6.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: @source_url,
      name: "DataForSeo",
      docs: [main: DataForSeo],
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {DataForSeo.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bypass, "~> 2.0", only: :test},
      {:ecto_sql, "~> 3.12.0"},
      {:ex_doc, ">= 0.0.0", only: [:dev, :docs]},
      {:finch, "~> 0.13"},
      {:jason, "~> 1.0"},
      {:timex, "~> 3.7.11"}
    ]
  end

  defp description do
    """
    DataForSEO client library for elixir.
    """
  end

  defp package do
    [
      maintainers: ["razue"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
