Spree::LineItem.class_eval do

  has_many :digital_links, :dependent => :destroy

  def digital?
    variant.digital?
  end

  def create_digital_links
    digital_links.delete_all

    #include master variant digitals
    master = variant.product.master
    if(master.digital?)
      create_digital_links_for_variant(master)
    end
    create_digital_links_for_variant(variant)
  end

  private
  def create_digital_links_for_variant(variant)
    variant.digitals.each do |digital|
      self.quantity.times do
        digital_links.create!(:digital => digital)
      end
    end
  end


end
