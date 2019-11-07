require 'spec_helper'

describe Picturefill::ViewHelper do
  include ControllerTestHelpers,
          Picturefill::ViewHelper

  describe '#imgset_tag' do
    context 'no arguments' do
      specify do
        expect { imgset_tag }.to raise_error(ArgumentError)
      end
    end

    context 'one argument' do
      specify do
        output = imgset_tag('hello.jpg')
        expect(output).to eq("<img src=\"hello.jpg\"></img>")
      end
    end

    context 'alt option' do
      subject { imgset_tag("banner.jpeg", "banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x") }

      it "should add the data-alt atribute" do
        is_expected.
          to eq("<img src=\"banner.jpeg\" srcset=\"banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x\"></img>")
      end
    end

    context 'alt option and block' do
      subject do
        imgset_tag("banner.jpeg", "banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x", alt: "The Breakfast Combo")
      end

      it "should add a piture src" do
        is_expected.to eq("<img alt=\"The Breakfast Combo\" src=\"banner.jpeg\" srcset=\"banner-HD.jpeg 2x, banner-phone.jpeg 100w,banner-phone-HD.jpeg 100w 2x\"></img>")
      end
    end
  end
end
