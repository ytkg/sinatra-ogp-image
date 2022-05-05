# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'victor'

class Title < String
  def font_size
    size = self.chars.map { |char| char.bytesize == 1 ? 1 : 2 }.sum
    size <= 2 ? 500 : 2000 / size
  end
end

get '/' do
  content_type 'text/xml'

  title = Title.new(params[:title] || 'Hello')
  svg = Victor::SVG.new width: 1200, height: 630

  svg.build do
    rect x: 0, y: 0, width: 1200, height: 630, fill: '#000'
    rect x: 20, y: 20, width: 1160, height: 590, fill: '#fff'
    g font_family: 'arial', font_weight: 'bold', font_size: title.font_size, text_anchor: 'middle', dominant_baseline: 'central' do
      text title, x: '50%', y: '50%'
    end
  end

  svg.render
end
