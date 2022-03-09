defmodule ExmealWeb.MealsViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View

  import Exmeal.Factory

  alias Exmeal.Meal

  alias ExmealWeb.MealsView

  test "render create.json" do
    insert(:user)

    params = build(:meals_params)
    {:ok, %Meal{id: _id} = meal} = Exmeal.create_meal(params)

    response = render(MealsView, "create.json", meal: meal)

    assert %{
             message: "Meal created!",
             meal: %Exmeal.Meal{
               __meta__: _meta,
               calories: 20,
               date: _date,
               description: "Banana",
               id: _id,
               inserted_at: _inserted_at,
               updated_at: _updated_at,
               user: _user,
               user_id: "69961117-d966-4e2f-ac55-476d4f78dddf"
             }
           } = response
  end

  test "render meal.json" do
    user_id = "69961117-d966-4e2f-ac55-476d4f78dddf"
    insert(:user)

    params = build(:meals_params)
    {:ok, %Meal{id: id} = meal} = Exmeal.create_meal(params)

    response = render(MealsView, "meal.json", meal: meal)

    assert %{
             meal: %Meal{
               calories: 20,
               date: _date,
               description: "Banana",
               id: ^id,
               user_id: ^user_id
             }
           } = response
  end
end
