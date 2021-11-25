defmodule SchemaTest do
  use ExUnit.Case

  import Absinthe

  alias Schema

  test "Query book()" do
    assert %{data: %{"book" => data}} = run!("""
      query {
        book(id: "some uuid") {
          id
          title
          shop
          awesomeOwner
        }
      }
    """, Schema)

    assert data["id"] == "some uuid"
    assert data["title"] == "title of the book some uuid"
    assert data["shop"] == "shop of the book some uuid"
    assert data["awesomeOwner"] == "owner of the book some uuid"
  end

  test "Mutation createBook()" do
    assert %{data: %{"createBook" => data}} = run!("""
      mutation {
        createBook(book: {
          title: "title of the book"
          shop: "some other uuid"
          awesomeOwner: "some uuid"
        }) {
          id
          title
          shop
          awesomeOwner
        }
      }
    """, Schema)

    assert "fake uuid " <> _ = data["id"]
    assert data["title"] == "title of the book"
    assert data["shop"] == "some other uuid"
    assert data["awesomeOwner"] == "some uuid"
  end
end
