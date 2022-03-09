defmodule Exmeal.Meals.Update do
  alias Exmeal.{Error, Repo, Meal}
  alias Exmeal.Meals.DateTimeFormatter

  def call(%{"id" => id} = params) do
    case Repo.get(Meal, id) do
      nil -> {:error, Error.build_meal_not_found_error()}
      meal -> do_update(meal, params)
    end
  end

  defp do_update(meal, params) do
    params = DateTimeFormatter.call(params)

    meal
    |> Meal.changeset(params)
    |> Repo.update()
  end
end
