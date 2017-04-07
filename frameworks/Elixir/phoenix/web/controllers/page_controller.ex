defmodule Hello.PageController do
  use Hello.Web, :controller
  alias Hello.World
  alias Hello.Fortune

  def index(conn, _params) do
    conn
    |> json(%{"TE Benchmarks\n" => "Started"})
  end

  # avoid namespace collision
  def _json(conn, _params) do
    conn
    |> json(%{message: "Hello, world!"})
  end

  defmodule WorldJson do
    @derive [Poison.Encoder]
    defstruct [:id, :randomNumber]
  end

  def db(conn, _params) do
    query =
      from(World)
      |> select([w], {w.id, w.randomnumber})

    {id, randomnumber} = Repo.get(query, :rand.uniform(10000))
    conn
    |> json(%WorldJson{id: id, randomNumber: randomnumber})
  end

  def queries(conn, params) do
    q = try do
      case String.to_integer(params["queries"]) do
        x when x < 1    -> 1
        x when x > 500  -> 500
        x               -> x
      end
    rescue
      ArgumentError -> 1
    end

    query =
      from(World)
      |> select([w], {w.id, w.randomnumber})

    queries = Enum.map(1..q, fn _ ->
      {id, randomnumber} = Repo.get(query, :rand.uniform(10000))
      %WorldJson{id: id, randomNumber: randomnumber}
    end)

    conn
    |> json(queries)
  end

  def fortunes(conn, _params) do
    additional_fortune = {
      0,
      "Additional fortune added at request time."
    }
    query =
      "fortune"
      |> select([f], {f.id, f.message})
    fortunes = [additional_fortune | Repo.all(query)]
    render conn, "fortunes.html", fortunes: Enum.sort(fortunes, fn f1, f2 -> elem(f1, 1) < elem(f2, 1) end)
  end

  def updates(conn, params) do
    q = try do
      case String.to_integer(params["queries"]) do
        x when x < 1    -> 1
        x when x > 500  -> 500
        x               -> x
      end
    rescue
      ArgumentError -> 1
    end

    conn
    |> json(Enum.map(1..q, fn _ ->
      id = :rand.uniform(10000)
      num = :rand.uniform(10000)
      w = Repo.get(World, id)
      changeset = World.changeset(w, %{randomnumber: num})
      Repo.update(changeset)
      %{id: id, randomnumber: num}
    end))
  end

  def plaintext(conn, _params) do
    conn
    |> text("Hello, world!")
  end
end
