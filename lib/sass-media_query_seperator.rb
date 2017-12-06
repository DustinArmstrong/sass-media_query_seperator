#require "sass/media_query_combiner/version"
require "./lib/sass/media_query_seperator/seperator"
#require "./lib/sass/compile_file"
require "sass"

module Sass
  def self.compile_file(filename, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    css_filename = args.shift
    binding.pry
    Sass::Engine.for_file(filename, options).render.each_with_index { |result, i|
      if css_filename
        options[:css_filename] ||= css_filename
        open(i.to_s + css_filename, "w") {|css_file| css_file.write(result)}
        nil
      else
        result
      end
    }
  end
end

Sass::Engine.class_eval do
  def render_with_seperate
    Sass::MediaQuerySeperator::Seperator.seperate(render_without_seperate)
  end
  alias_method :render_without_seperate, :render
  alias_method :render, :render_with_seperate
  alias_method :to_css, :render_with_seperate

  def render_with_sourcemap_with_seperate(*args)
    rendered, sourcemap = render_with_sourcemap_without_seperate(*args)

    rendered = Sass::MediaQuerySeperator::Seperator.seperate(rendered)

    return rendered, sourcemap
  end
  alias_method :render_with_sourcemap_without_seperate, :render_with_sourcemap
  alias_method :render_with_sourcemap, :render_with_sourcemap_with_seperate
end
