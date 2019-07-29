class CharactersController < ApplicationController

    def index 
       characters = Character.all
       render json: characters.to_json(default)
    end 

    def show
        character = Character.find_by(id: params[:id])
        render json: character.to_json(avatar_inc)
    end 

    def update
        character = Character.find_by(id: params[:id])
        character.update(character_params)
        render json: character.to_json(default)
    end 

    def create 
        character = Character.create(character_params) 
        render json: character 
    end 

    def destroy 
        character = Character.find_by(id: params[:id])
        character.destroy 
        render json: character
    end

    private 

    def character_params
        params.require(:character).permit(:firstname, :lastname, :class_id, :level, :strength, :dexterity, :constitution, :intelligence, :charisma, :age, :height, :weight, :eyes, :skin, :hair, :background, :alignment)
    end 

    def default 
        {
            :except => [:created_at, :updated_at],
            :include => {
                :char_class=>{
                    :only => [:id,:name,:hit_die]
                },
                :proficiencies=>{
                    :except => [:id,:created_at, :updated_at]
                }
            }
        }
    end
    
    def avatar_inc
        {
            :except => [:created_at, :updated_at],
            :methods => [:avatar_url,:image_url],
            :include => {
                :char_class=>{
                    :only => [:id,:name,:hit_die]
                },
                :proficiencies=>{
                    :except => [:id,:created_at, :updated_at]
                }
            }
        }
    end 

end


# Format include AS
# :except => [:created_at, :updated_at],
# :include => {
#     :char_class=>{
#         :only => [:id,:name,:hit_die]
#     },
#     :proficiencies=>{
#         :except => [:id,:created_at, :updated_at]
#     }
#     ,
#         :avatar=>{
#         }
#     ,
#     :skills => {
#         :except => [:id,:created_at, :updated_at]
#     }
# }