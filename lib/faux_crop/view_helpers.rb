module FauxCrop
  module ViewHelpers

    def faux_crop(image_path, width, height, target_size, original_crop_x = nil, original_crop_y = nil, original_crop_size = nil )
      fc = FauxCropper.new(width, height, target_size, original_crop_x, original_crop_y, original_crop_size)
      content_tag(:div, style:fc.css_style_for_container) do
        image_tag(image_path, style:fc.css_style_for_image)
      end       
    end

    class FauxCropper
       def initialize(width, height, target_size, original_crop_x, original_crop_y, original_crop_size) 
         @width              = width.to_f
         @height             = height.to_f
         @target_size        = target_size.to_f
         @original_crop_x    = original_crop_x.to_f if original_crop_x
         @original_crop_y    = original_crop_y.to_f if original_crop_y
         @original_crop_size = original_crop_size.to_f if original_crop_size
      end

      def css_style_for_image
        if coordinates_for_cropping?
          css_style = css_style_for_cropped_image
        else
          css_style = css_style_for_gravity_crop
        end
        css_style
      end

      def coordinates_for_cropping?
        @original_crop_x.present?
      end

      def css_style_for_cropped_image
        frame_multiplier = @width / @original_crop_size  # how larger was the image compared to the crop
        offset_multiplier = @target_size/@original_crop_size
        new_width = @target_size * frame_multiplier   
        # new_height: auto
        x_offset = - @original_crop_x * offset_multiplier
        y_offset = - @original_crop_y * offset_multiplier

        css_style="width:#{new_width}px; max-width:none;height:auto; margin-left:#{x_offset}px; margin-top:#{y_offset}px; display:block;"  
      end

      def css_style_for_gravity_crop
        ratio = @width / @height
        if ratio > 1
          normalized_width = (@target_size * ratio).round
          offset=(@target_size - normalized_width)/2
          css_style="height:#{@target_size}px; width:auto; max-width:none;margin-left:#{offset}px"
        else
          normalized_height = (@target_size / ratio).round
          offset=(@target_size - normalized_height)/2      
          css_style="width:#{@target_size}px; height:auto;margin-top:#{offset}px"      
        end
        css_style << "; display:block"
      end

      def css_style_for_container
        "position: relative; overflow:hidden; width:#{@target_size}px; height:#{@target_size}px"
      end         

    end

  end
end