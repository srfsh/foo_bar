defmodule Schema do
  use Absinthe.Schema

  object :book do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :shop_id, non_null(:id), name: "shop"
    field :awesome_owner_id, non_null(:id), name: "awesomeOwner"
  end

  input_object :create_book_params do
    field :title, non_null(:string)
    field :shop_id, non_null(:id), name: "shop"
    field :awesome_owner_id, non_null(:id), name: "awesomeOwner"
  end

  query do
    field :book, :book do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ ->
        {:ok, %{
          id: id,
          title: "title of the book #{id}",
          shop_id: "shop of the book #{id}",
          awesome_owner_id: "owner of the book #{id}"
        }}
      end
    end
  end

  mutation do
    field :create_book, :book do
      arg :book, non_null(:create_book_params)
      resolve fn %{book: %{title: title, awesome_owner_id: awesome_owner_id, shop_id: shop_id}}, _ ->
        {:ok, %{
          id: "fake uuid #{System.unique_integer([:positive])}",
          title: title,
          shop_id: shop_id,
          awesome_owner_id: awesome_owner_id
        }}
      end
    end
  end
end
