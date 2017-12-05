require 'spec_helper'
require 'sass/media_query_combiner/combiner'

describe Sass::MediaQuerySeperator::Seperator do
  it "should handle keyframes in media queries" do
    Timeout::timeout(0.5) do
      Sass::MediaQuerySeperator::Seperator.combine <<CSS
@media (min-width: 40em) {
  @-webkit-keyframes whatever {}
}
CSS
    end
  end

  it "should handle debug info" do
    Timeout::timeout(0.5) do
      Sass::MediaQuerySeperator::Seperator.combine <<CSS
@media (max-width: 480px) {
@media -sass-debug-info {filename{}line{}}
  h1 {
    color: red; } }
CSS
    end
  end
end
