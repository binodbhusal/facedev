class MembersController < ApplicationController
    before_action :authenticate_user!, only: %i[edit_description update_description 
    edit personal_details update personal_details]
    
    def show 
        @user = User.find(params[:id])
        @connections = Connection.where('user_id= ? OR connected_user_id=?', params[:id],params[:id]).where(status:'accepted')
        @mutual_connections = current_user.mutually_connected_ids(@user)
    end
    def edit_description; end
        def update_description
            respond_to do |format|
                if current_user.update(bio: params[:user][:bio])
                    format.turbo_stream{render turbo_stream: turbo_stream.replace('user-description', partial:'members/user_description', locals: { user:current_user })}
                end
            end 
            end
            def edit_personal_details; end
            
            def update_personal_details
                respond_to do |format|
                    if current_user.update(personal_details_params)
                        format.turbo_stream{render turbo_stream: turbo_stream.replace('user-personal-details', partial:'members/user_personal_details', locals: { user:current_user })}
                    end
                end 
            end
            def connections 
              @user = User.find(params[:id])
              @connected_user = if params[:mutual_connections].present?
                mutualy_connected_ids = current_user.mutually_connected_ids(@user)
              User.where(id:mutualy_connected_ids)
              else 
                User.where(id:@user.connected_user_ids)
              end
                @total_connections = @connected_user.count
            end 
            private 
            def personal_details_params
                params.require(:user).permit(:first_name, :last_name, :country, :city, :profile_title)
            end

end