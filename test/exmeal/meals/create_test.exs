defmodule Exmeal.Meals.CreateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Meal

  describe "Create Meal" do
    test "when all params are valid, returns the meal" do
      user_id = "69961117-d966-4e2f-ac55-476d4f78dddf"
      insert(:user)

      params = build(:meals_params)

      {:ok, %Meal{id: id} = response} = Exmeal.create_meal(params)

      assert %Exmeal.Meal{
               calories: 20,
               date: _date,
               description: "Banana",
               id: ^id,
               user_id: ^user_id
             } = response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        "calories" => 20,
        "date" => ~D[2001-05-02],
        "user_id" => "69961117-d966-4e2f-ac55-476d4f78dddf"
      }

      response = Exmeal.create_meal(params)

      assert {:error, %Exmeal.Error{}} = response
    end
  end
end
