class ApiController < ApplicationController
    def index
        @apis = Api.all
#        render json: {staus: 200,data: @apis}
        render json: @apis
    end
    
    def create
    end
    
    def search
        str = params[:name]
        @ret = Api.where("name like '%" + str + "%'")
        render json: @ret
    end

    def show
        @ret = Api.find(params[:id])
        render json: @ret
    end
        
    def update
        @data = Api.find_by_id(params[:id])
        render_error(404, "resource not found") and return unless @data
        @data.name = params[:name]
        @data.save!
        render json: @data
    end

    def create  
        (render_error(400, "missing name param") unless params[:name]) and return
        @data = Api.create({ :name => params[:name] })
        render json: @data
    end
    
    def destroy
        p params
        @data = Api.find_by_id(params[:id])
        render_error(404, "resource not found") and return unless @data
        @data.delete
        head 200
    end
end
