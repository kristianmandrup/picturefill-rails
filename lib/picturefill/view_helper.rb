module Picturefill
  class ViewHelper
    def picturefill options = {}, &block
      alt = options.delete(:alt]
      clazz = options.delete(:class)
      opts = options.merge(:"data-alt" => alt, :"class" => clazz, :"data-picture" => true)

      content = block_given? ? capture(&block) : ''
      content_tag :div, content, options
    end

    def pic_src src, media=nil, options = {}
      options.merge! {:"data-src" => src}

      ratio_opt = options[:ratio]
      media = Picturefill::ViewHelper.extract media

      unless media && media =~ /min-device-pixel-ratio/
        # use filename to provide ratio_opt
        fn = filename(src) =~ /_x\d(\d)?/
        if fn && !ratio_opt
          ratio_opt = fn.match(/_x\d(\d)?/).to_s
        end

        if ratio_opt          
          auto_ratio_tag = ratio[0] == 'x'    
          ratio = Picturefill::ViewHelper.ratio_attrib ratio_opt if ratio_opt
        end

        media = [media, ratio].compact.join(' and ')
      end
      
      options.merge!(:"data-media" => media)

      capture do
        content_tag :div, content, options
        if auto_ratio_tag
          filename = Picturefill::ViewHelper.ratio_file_name src, ratio_opt
          pic_src filename, options.merge(:ratio => ratio_opt)
        end
      end
    end

    def pic_fallback src, options = {}
      content_tag :noscript, image_tag(src, options)
    end

    class << self
      def filename src
        src_parts = src.split('.')
        ext = src_parts[1..-1].join('.')
        src_parts.first
      end

      def ratio_file_name src, ratio_opt
        ratio_opt = ratio_opt.delete('x')
        "#{filename(src)}_x2.#{ext}"
      end

      def extract media
        case media 
        when /^(\d+)$/
          "(min-width: #{media}px)"
        when /^(\d+)px$/
          "(min-width: #{media})"
        when /min-width: (\d+)$/
          "(#{media}px)"
        when /min-width: (\d+)px$/
          "(#{media})"
        else 
          raise ArgumentError, "Picturefill :media attribute could not be parsed, was: #{media}"
        end
      end

      def ratio_attrib ratio
        ratio = ratio.to_s.delete!('x')
        minor = 0
        case ratio.to_s
        when /^\d/
          major = ratio
        when /^\d.\d/
          major, minor = ratio.split '.'        
        else
          raise ArgumentError, "Invalid ratio, must be a number, fx '2.5' or '2' (even 'x2' or 'x2.5')"
        end
        ratio_attribute major, minor
      end      

      protected

      def ratio_attribute major, minor
        "(min-device-pixel-ratio: #{major}.#{minor})"
      end
    end # class methods
  end
end