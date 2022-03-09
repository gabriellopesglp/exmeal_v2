defmodule Exmeal.Meals.GetTest do
  use Exmeal.DataCase

  import Exmeal.Factory

  alias Exmeal.Meal

  describe "Get Meal" do
    test "when a valid id is given, returns the meal" do
      user_id = "69961117-d966-4e2f-ac55-476d4f78dddf"
      insert(:user)

      params = build(:meals_params)

      {:ok, %Meal{id: id}} = Exmeal.create_meal(params)

      response = Exmeal.get_meal_by_id(id)

      assert {:ok,
              %Exmeal.Meal{
                calories: 20,
                date: _date,
                description: "Banana",
                id: ^id,
                user_id: ^user_id
              }} = response
    end

    test "when an invalid id is given, returns an error" do
      id = "a6ef9b39-d638-4835-9ad7-dbe48d1257eb"
      response = Exmeal.get_meal_by_id(id)

      assert {:error, %Exmeal.Error{result: "Meal not found", status: :not_found}} == response
    end
  end
end
