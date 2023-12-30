class MembersController < ApplicationController
  
    def show 
        @user = User.find(params[:id])
        @connections = Connection.where('user_id= ? OR connected_user_id=?', params[:id],params[:id]).where(status:'accepted')
        @mutual_connections = current_user.mutually_connected_ids(@user)
    end
    def edit_description; end

        def update_description
                if current_user.update(bio: params[:user][:bio])
                    render_turbo_stream(
                        'replace',
                        'user-description',
                        'members/user_description',
                        { user:current_user }
                    )
                end
            end
            
            def edit_personal_details; end
            
            def update_personal_details
              
                    if current_user.update(personal_details_params)
                        render_turbo_stream(
                            'replace',
                            'user-personal-details',
                            'members/user_personal_details',
                            { user:current_user }
                        )             
                end 
            end

            def connections 
              @user = User.find(params[:id])
              @total_users = if params[:mutual_connections].present?
              User.where(id:current_user.mutually_connected_ids(@user))
              else 
                User.where(id:@user.connected_user_ids)
              end
                @connected_user = @total_users.page(params[:page]).per(10)
                @total_connections = @total_users.count
            end 

            private 
            def personal_details_params
                params.require(:user).permit(:first_name, :last_name, :country, :city, :profile_title)
            end

end