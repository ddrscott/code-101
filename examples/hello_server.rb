require 'rack'
# html_data = File.read('examples/hello.html')

def render_numbers(count)
  output = ''
  count.times do |i|
    even_odd = ''
    if i % 2 == 0
      even_odd = 'even'
    else
      even_odd = 'odd'
    end
    output = output + '<p class="' + even_odd  + '">i: ' + i.to_s + ', ' + even_odd + '</p>'
  end
  return output
end

def html_data
  return <<-HTML
  <html>
    <head>
      <style>
  h1 {
    color: red;
    font-size: 100%;
  }
  .even {
    color: yellow;
  }
  .odd {
    background: blue;
  }
      </style>
    </head>
    <body>
      <h1>Hello World from Ruby!!!!</h1>
      <p>
        Welcome to class!
        The time is: #{ Time.now }
      </p>
      #{ render_numbers(20) }
    </body>
  </html>
  HTML
end

app = Proc.new do |env|
  [
    '200',
    {'Content-Type' => 'text/html'},
    [html_data]
  ]
end
Rack::Handler::WEBrick.run app
