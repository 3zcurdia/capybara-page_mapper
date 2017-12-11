# frozen_string_literal: true

require 'rack'
require 'rack/server'

class TestApp
  def self.call(_env)
    new.response
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
      <input type="text" name="password" id="user_password"/>
      <select name="maritial_status" id="user_marital_status">
        <option value="single">Single</option>
        <option value="married">Married</option>
        <option value="divorced">Divorced</option>
        <option value="widowed">Widowed</option>
      </select>
      <input type="submit" value="Submit" id="log_in">
    </form>
    <body>
    </html>
    STRING
  end
end
