class Application < Sinatra::Base
  configure do
    set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg *.eot *.ttf *.woff)
    set :assets_prefix, %w(assets vendor/assets)
    set :assets_css_compressor, :sass
    set :assets_js_compressor, :uglifier
    register Sinatra::AssetPipeline

    # Actual Rails Assets integration, everything else is Sprockets
    if defined?(RailsAssets)
      RailsAssets.load_paths.each do |path|
        settings.sprockets.append_path(path)
      end
    end
  end

  get '/' do
    slim :index
  end

  get '/generate', layout: false do
    json generate_sequence(params[:size].to_i)
  end

  def generate_sequence(size)
    result = []
    (size).times do
      result << (result.empty? ? '1' : result.last.scan(/((\d)\2*)/).map { |element| element.tap { |x| x[0] = x[0].length.to_s } }.flatten.join)
    end
    result
  end
end