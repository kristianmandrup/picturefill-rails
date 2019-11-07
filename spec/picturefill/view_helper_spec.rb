require 'spec_helper'

describe Picturefill::ViewHelper do
  include ControllerTestHelpers,
          Picturefill::ViewHelper

  describe '#picturefill' do
    context 'without arguments' do
      subject { picturefill {} }

      it "should be empty with a data-picture attribute" do
        is_expected.to eq("<div data-picture=\"true\"></div>")
      end
    end

    context 'alt option' do
      subject {  picturefill(alt: 'nice pic') {} }

      it "should add the data-alt atribute" do
        is_expected.to eq("<div data-alt=\"nice pic\" data-picture=\"true\"></div>")
      end
    end

    context 'alt option and block' do
      subject { picturefill(alt: 'nice pic') { picture_src('small.jpg') } }

      it "should add a piture src" do
        is_expected.to eq("<div data-alt=\"nice pic\" data-picture=\"true\"><div data-src=\"small.jpg\"></div></div>")
      end
    end
  end

  describe '#picture_src' do
    context 'filename with media: 400' do
      subject { picture_src('small.jpg', 400) }

      it "should add a piture src with ratio and 400px min width" do
        is_expected.to eq("<div data-media=\"(min-width: 400px)\" data-src=\"small.jpg\"></div>")
      end
    end

    context 'filename with _x2' do
      subject { picture_src('small_x2.jpg') }

      it "should add a piture src" do
        is_expected.to eq("<div data-media=\"(min-device-pixel-ratio: 2.0)\" data-src=\"small_x2.jpg\"></div>")
      end
    end

    context 'filename with _x2 and media: 400' do
      subject { picture_src('small_x2.jpg', 400) }

      it "should add a piture src with ratio and 400px min width" do
        is_expected.
          to eq("<div data-media=\"(min-width: 400px) and (min-device-pixel-ratio: 2.0)\" data-src=\"small_x2.jpg\"></div>")
      end
    end

    context "filename and ratio: 'x2'" do
      subject { picture_src('small.jpg', ratio: 'x2') }

      it "should add an extra piture src for Retina with x2" do
        is_expected.
          to eq("<div data-src=\"small.jpg\"></div><div data-media=\"(min-device-pixel-ratio: 2.0)\" data-src=\"small_x2.jpg\"></div>")
      end
    end
  end

  describe '#pic_fallback' do
    subject { picture_fallback('small.jpg') }

    it "should add a <noscript> fallback with a normal <img> tag as fallback" do
      is_expected.to eq("<noscript><img src=\"small.jpg\"></img></noscript>")
    end
  end
end
