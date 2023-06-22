class PagesController < ApplicationController
    def home
      redirect_to "/admin/login"
    end
end