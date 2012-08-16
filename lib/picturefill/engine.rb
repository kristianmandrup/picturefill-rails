module Picturefill
  module Rails
    class Engine < ::Rails::Engine
      initializer ' picturefill for rails setup' do
        ActiveView::Base.send :include, Picturefill::ViewHelper
      end
    end
  end
end
