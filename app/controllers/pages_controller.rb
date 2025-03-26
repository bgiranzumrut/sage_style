class PagesController < ApplicationController
  def about
    @page_content = PageContent.find_by(name: 'about')
  end

  def contact
    @page_content = PageContent.find_by(name: 'contact')
  end

  def home
    @featured_products = Product.featured
  end

end
