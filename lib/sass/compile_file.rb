module Sass
  module MediaQuerySeperator
    module CompileFile
      def self.compile_file(filename, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        css_filename = args.shift
        results = []
        binding.pry
        Sass::Engine.for_file(filename, options).render.each { |result|
          results << result
        }
        results.each do |result|
          if css_filename
            options[:css_filename] ||= css_filename
            open(css_filename+i, "w") {|css_file| css_file.write(result)}
            nil
          else
            result
          end
        end
        super
      end
    end
  end
end
