require 'rack'
require 'rack/server'

class TestApp
  def self.call(env)
    self.new.response
  end

  def response
    [200, {}, [body]]
  end

  def body
    <<-STRING
    <!DOCTYPE html>
    <html>
    <head>
      <title>TestApp</title>
    </head>
    <body>
    <form>
      <input type="text" name="name" id="user_email"/>
      <input type="text" name="meh" id="user_password"/>
      <input type="submit" value="Submit" id="log_in">
    </form>
    <body>
    </html>
    STRING
  end
end
