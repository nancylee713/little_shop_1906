class CartController<ApplicationController
  include ActionView::Helpers::TextHelper

  def add_item
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    session[:cart][item_id_str] = session[:cart][item_id_str] + 1
    quantity = session[:cart][item_id_str]
    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{item.name} in your cart."
    redirect_to "/items"
  end

  def remove_item
    item = Item.find(params[:item_id])
    @cart = Cart.new(session[:cart])
    @cart.contents.delete(item.id.to_s)
    redirect_to "/cart"
  end

  def show
    @cart = Cart.new(session[:cart])
  end

  def empty
    reset_session
    redirect_to "/cart"
  end
end
