#require "sass/media_query_combiner/version"
require "./lib/sass/media_query_seperator/seperator"
require "./lib/sass/compile_file"
require "sass"

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

include Sass

Sass.module_eval { include Sass::MediaQuerySeperator::CompileFile }
