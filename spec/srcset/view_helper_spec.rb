require 'spec_helper'

describe Picturefill::ViewHelper do
  include ControllerTestHelpers,
          Picturefill::ViewHelper

  describe '#imgset_tag' do
    context 'no arguments' do
      specify do
        expect { imgset_tag }.to raise_error
      end
    end

    context 'one argument' do
      specify do
        output = imgset_tag('hello.jpg')
        output.should  == "<img src=\"hello.jpg\"></img>"
      end
    end

    context 'alt option' do
      it "should add the data-alt atribute" do
        output = imgset_tag "banner.jpeg", "banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x"
        output.should == "<img src=\"banner.jpeg\" srcset=\"banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x\"></img>"
      end
    end

    context 'alt option and block' do
      it "should add a piture src" do
        output = imgset_tag "banner.jpeg", "banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x", alt: "The Breakfast Combo"
        output.should == "<img alt=\"The Breakfast Combo\" src=\"banner.jpeg\" srcset=\"banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x\"></img>"
      end
    end
  end
end