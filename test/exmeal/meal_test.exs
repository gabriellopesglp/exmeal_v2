defmodule Exmeal.MealTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Ecto.Changeset

  alias Exmeal.Meal

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      user_params = build(:users_params)

      Exmeal.create_user(user_params)

      response =
        :meal_changeset
        |> build()
        |> Meal.changeset()

      assert %Changeset{
               changes: %{
                 description: "Banana",
                 date: _date,
                 calories: 20,
                 user_id: _user_id
               },
               valid?: true
             } = response
    end
  end
end
