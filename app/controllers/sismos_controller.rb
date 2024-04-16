# app/controllers/sismos_controller.rb
class SismosController < ApplicationController
    def index
      @sismos = Sismo.all
    end
  end
  