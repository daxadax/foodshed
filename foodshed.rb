class Foodshed < Sinatra::Application
  get '/' do
    display_page 'all'
  end
end

helpers do
  def display_page(title, locals: {}, layout: 'default')
    haml title.to_sym, layout: "layouts/#{layout}".to_sym, locals: locals
  end

  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
end
