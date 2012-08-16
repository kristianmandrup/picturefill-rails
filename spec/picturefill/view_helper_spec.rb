require 'spec_helper'

describe Picturefill::ViewHelper do
  include ControllerTestHelpers,
          Picturefill::ViewHelper

  describe '#picturefill' do
    context 'no arguments' do
      it "should be empty with a data-picture attribute" do
        output = picturefill do
        end
        output.should == "<div data-picture=\"true\"></div>"
      end
    end

    context 'alt option' do
      it "should add the data-alt atribute" do
        output = picturefill alt: 'nice pic' do
        end
        output.should == "<div data-alt=\"nice pic\" data-picture=\"true\"></div>"
      end
    end

    context 'alt option and block' do
      it "should add a piture src" do
        output = picturefill alt: 'nice pic' do
          picture_src 'small.jpg'
        end
        output.should == "<div data-alt=\"nice pic\" data-picture=\"true\"><div data-src=\"small.jpg\"></div></div>"
      end
    end
  end

  describe '#picture_src' do
    context 'filename with media: 400' do
      it "should add a piture src with ratio and 400px min width" do
        output = picture_src 'small.jpg', 400
        output.should == "<div data-media=\"(min-width: 400px)\" data-src=\"small.jpg\"></div>"
      end
    end

    context 'filename with _x2' do
      it "should add a piture src" do
        output = picture_src 'small_x2.jpg'
        output.should == "<div data-media=\"(min-device-pixel-ratio: 2.0)\" data-src=\"small_x2.jpg\"></div>"
      end
    end

    context 'filename with _x2 and media: 400' do
      it "should add a piture src with ratio and 400px min width" do
        output = picture_src 'small_x2.jpg', 400
        output.should == "<div data-media=\"(min-width: 400px) and (min-device-pixel-ratio: 2.0)\" data-src=\"small_x2.jpg\"></div>"
      end
    end

    context "filename and ratio: 'x2'" do
      it "should add an extra piture src for Retina with x2" do
        output = picture_src 'small.jpg', ratio: 'x2'
        output.should == "<div data-src=\"small.jpg\"></div><div data-media=\"(min-device-pixel-ratio: 2.0)\" data-src=\"small_x2.jpg\"></div>"
      end
    end
  end

  describe '#pic_fallback' do
    it "should add a <noscript> fallback with a normal <img> tag as fallback" do
      output = picture_fallback 'small.jpg'
      output.should == "<noscript><img src=\"small.jpg\"></img></noscript>"
    end
  end
end