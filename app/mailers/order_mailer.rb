class OrderMailer < ApplicationMailer

  def email_order_receipt(order, product)
    @order = order
    @order_product = product
    mail(to: order.email, subject: "Jungle order #{@order.id}")
  end

end
