# app/controllers/features_controller.rb
class FeaturesController < ApplicationController
    def index
      @sismos = Sismo.all # Obtener todos los registros de la tabla Feature
    end
  end
  