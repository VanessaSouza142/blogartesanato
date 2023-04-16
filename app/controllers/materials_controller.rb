class MaterialsController < ApplicationController
    before_action :set_material, only: [:edit, :update, :show]
    before_action :require_admin, except: [:show, :index]

    def new
        @material = Material.new
    end
    
    def create
        @material = Material.new(material_params)
        if @material.save
            flash[:success] = "O material foi criado com sucesso!"
            redirect_to material_path(@material)
        else
            render 'new', status: :unprocessable_entity
        end
    end
    
    def edit
      
    end
    
    def update
        if @material.update(material_params)
            flash[:success] = "O material foi atualizado com sucesso!"
            redirect_to @material
        else
            render 'edit'
        end      
    end
    
    def show
        @material_handcrafts = @material.handcrafts.paginate(page: params[:page], per_page: 5)
    end
    
    def index
      @materials = Material.paginate(page: params[:page], per_page: 5)
    end

    private

    def material_params
        params.require(:material).permit(:name)
    end

    def set_material
        @material = Material.find(params[:id])
    end

    def require_admin
        if !logged_in? || (logged_in? and !current_artisan.admin?)
          flash[:danger] = "Somente o administrador pode executar essa ação!"
          redirect_to materials_path
        end
    end
    
end