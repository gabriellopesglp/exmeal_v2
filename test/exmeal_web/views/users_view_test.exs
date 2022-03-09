defmodule ExmealWeb.UsersViewTest do
  use ExmealWeb.ConnCase, async: true

  import Phoenix.View

  import Exmeal.Factory

  alias Exmeal.User

  alias ExmealWeb.UsersView

  test "render create.json" do
    user_params = build(:users_params)

    {:ok, %User{id: _id} = user} = Exmeal.create_user(user_params)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %Exmeal.User{
               __meta__: _meta,
               cpf: "12345678900",
               email: "jp@banana.com",
               id: _id,
               inserted_at: _inserted,
               meals: _meals,
               name: "Jp",
               updated_at: _updated
             }
           } = response
  end

  test "render user.json" do
    user_params = build(:users_params)

    {:ok, %User{id: id} = user} = Exmeal.create_user(user_params)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               cpf: "12345678900",
               name: "Jp",
               email: "jp@banana.com",
               id: ^id
             }
           } = response
  end
end
