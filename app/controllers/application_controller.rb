class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    render html: "hello, Trung Map hahahaha hihihihi hehehehe hoohohoho!"
  end
end
 	