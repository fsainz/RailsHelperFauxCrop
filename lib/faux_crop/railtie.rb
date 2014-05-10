require 'faux_crop/view_helpers'

module FauxCrop
  class Railtie < Rails::Railtie
    initializer "faux_crop.view_helpers" do |app|
      ActionView::Base.send :include, ViewHelpers
    end
  end 
end