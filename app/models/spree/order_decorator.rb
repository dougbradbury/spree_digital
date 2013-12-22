Spree::Order.state_machine.before_transition :to => :complete, :do => :generate_digital_links
Spree::Order.class_eval do

  def generate_digital_links
    digital_shipping_methods = Spree::ShippingMethod.joins(:calculator).where('spree_calculators.type' => "Spree::Calculator::Shipping::DigitalDelivery")
    shipments.each do |shipment|
      if digital_shipping_methods.include?(shipment.shipping_method)
        shipment.line_items.each do |item|
          item.create_digital_links if item.digital?
        end
      end
    end
    true
  end

  def digital?
    line_items.all? { |item| item.digital? }
  end

  def some_digital?
    line_items.any? { |item| item.digital? }
  end

  def digital_line_items
    line_items.select(&:digital?)
  end

  def digital_links
    digital_line_items.map(&:digital_links).flatten
  end

  def reset_digital_links!
    digital_links.each do |digital_link|
      digital_link.reset!
    end
  end

end
