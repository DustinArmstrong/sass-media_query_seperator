module Sass
  def self.compile_file(filename, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    css_filename = args.shift
    Sass::Engine.for_file(filename, options).render.each_with_index { |result, i|
      binding.pry
      if css_filename
        options[:css_filename] ||= css_filename
        open(i.to_s + css_filename, "w") {|css_file| css_file.write(result)}
        nil
      else
        result
      end
    }
    super
  end
end
