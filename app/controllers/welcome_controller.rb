class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "Curso de Ruby on Rails - Felipe Guinossi [COOKIE]"
    #session[:curso] = "Curso de Ruby on Rails - Felipe Guinossi [SESSION]"
    @meu_nome = params[:nome]
    @meu_curso = params[:curso]
  end
end
