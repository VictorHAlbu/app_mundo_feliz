require "application_system_test_case"

class PedidoPodutosTest < ApplicationSystemTestCase
  setup do
    @pedido_poduto = pedido_podutos(:one)
  end

  test "visiting the index" do
    visit pedido_podutos_url
    assert_selector "h1", text: "Pedido Podutos"
  end

  test "creating a Pedido poduto" do
    visit pedido_podutos_url
    click_on "New Pedido Poduto"

    fill_in "Pedido", with: @pedido_poduto.pedido_id
    fill_in "Produto", with: @pedido_poduto.produto_id
    fill_in "Quantidade", with: @pedido_poduto.quantidade
    fill_in "Valor", with: @pedido_poduto.valor
    click_on "Create Pedido poduto"

    assert_text "Pedido poduto was successfully created"
    click_on "Back"
  end

  test "updating a Pedido poduto" do
    visit pedido_podutos_url
    click_on "Edit", match: :first

    fill_in "Pedido", with: @pedido_poduto.pedido_id
    fill_in "Produto", with: @pedido_poduto.produto_id
    fill_in "Quantidade", with: @pedido_poduto.quantidade
    fill_in "Valor", with: @pedido_poduto.valor
    click_on "Update Pedido poduto"

    assert_text "Pedido poduto was successfully updated"
    click_on "Back"
  end

  test "destroying a Pedido poduto" do
    visit pedido_podutos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pedido poduto was successfully destroyed"
  end
end
