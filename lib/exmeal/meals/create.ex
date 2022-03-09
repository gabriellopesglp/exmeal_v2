defmodule Exmeal.Meals.Create do
  alias Exmeal.{Error, Repo, Meal, User}
  alias Exmeal.Meals.DateTimeFormatter

  def call(params) do
    params
    |> validate_user()
    |> handle_meals(params)
  end

  defp validate_user(params) do
    case Map.has_key?(params, "user_id") do
      false ->
        {:ok, "vazio"}

      true ->
        %{"user_id" => user_id} = params

        case Repo.get_by(User, id: user_id) do
          nil -> {:error, "User not found!"}
          user -> {:ok, user}
        end
    end
  end

  defp handle_meals({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_meals({:ok, _user}, params) do
    params
    |> DateTimeFormatter.call()
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Meal{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
