require 'test_helper'

class PedidoPodutosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pedido_poduto = pedido_podutos(:one)
  end

  test "should get index" do
    get pedido_podutos_url
    assert_response :success
  end

  test "should get new" do
    get new_pedido_poduto_url
    assert_response :success
  end

  test "should create pedido_poduto" do
    assert_difference('PedidoPoduto.count') do
      post pedido_podutos_url, params: { pedido_poduto: { pedido_id: @pedido_poduto.pedido_id, produto_id: @pedido_poduto.produto_id, quantidade: @pedido_poduto.quantidade, valor: @pedido_poduto.valor } }
    end

    assert_redirected_to pedido_poduto_url(PedidoPoduto.last)
  end

  test "should show pedido_poduto" do
    get pedido_poduto_url(@pedido_poduto)
    assert_response :success
  end

  test "should get edit" do
    get edit_pedido_poduto_url(@pedido_poduto)
    assert_response :success
  end

  test "should update pedido_poduto" do
    patch pedido_poduto_url(@pedido_poduto), params: { pedido_poduto: { pedido_id: @pedido_poduto.pedido_id, produto_id: @pedido_poduto.produto_id, quantidade: @pedido_poduto.quantidade, valor: @pedido_poduto.valor } }
    assert_redirected_to pedido_poduto_url(@pedido_poduto)
  end

  test "should destroy pedido_poduto" do
    assert_difference('PedidoPoduto.count', -1) do
      delete pedido_poduto_url(@pedido_poduto)
    end

    assert_redirected_to pedido_podutos_url
  end
end
