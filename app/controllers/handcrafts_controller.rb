class HandcraftsController < ApplicationController
    before_action :set_handcraft, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @handcrafts = Handcraft.paginate(page: params[:page], per_page: 5)
    end

    def show
        
    end

    def new
        @handcraft = Handcraft.new
    end

    def create
        @handcraft = Handcraft.new(handcraft_params)
        @handcraft.artisan = current_artisan
        if @handcraft.save
            flash[:success] = "O artesanato foi criado com sucesso!"
            redirect_to handcraft_path(@handcraft)
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def edit
        
    end
      
    def update
        if @handcraft.update(handcraft_params)
            flash[:success] = "O artesanato foi atualizado com sucesso!"
            redirect_to handcraft_path(@handcraft)
        else
          render 'edit'
        end
    end

      def destroy
        Handcraft.find(params[:id]).destroy
        flash[:success] = "O artesanato foi deletado com sucesso!"
        redirect_to handcrafts_path
      end

    private

        def set_handcraft
            @handcraft = Handcraft.find(params[:id])
        end

        def handcraft_params
            params.require(:handcraft).permit(:name, :description, material_ids: [])
        end

        def require_same_user
            if current_artisan != @handcraft.artisan and !current_artisan.admin?
              flash[:danger] = "Você só pode editar ou deletar os artesanatos criados por você"
              redirect_to handcrafts_path
            end  
        end
end