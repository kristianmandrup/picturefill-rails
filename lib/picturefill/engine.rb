module Picturefill
  module Rails
    class Engine < ::Rails::Engine
      initializer 'picturefill for rails' do
        ActionView::Base.send :include, ::Picturefill::ViewHelper
      end
    end
  end
end
