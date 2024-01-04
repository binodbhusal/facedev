class ConnectionsController < ApplicationController
  def index
    @requested_connections = Connection.includes(:requested).where(user_id: current_user.id)
    @received_connections = Connection.includes(:received).where(connected_user_id: current_user.id)
  end

  def update
    @connection = Connection.find(params[:id])

    respond_to do |format|
      ActiveRecord::Base.transaction do
        if @connection.update(connection_params) && (@connection.status == 'accepted')
          receiver = @connection.received
          receiver.connected_user_ids << @connection.requested.id
          receiver.save

          requester = @connection.requested
          requester.connected_user_ids << @connection.received.id
          requester.save
        end

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("connection-status-#{@connection.id}",
                                                    partial: 'connections/update', locals: { connection: @connection })
        end
      rescue StandardError => e
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("connection-status-#{@connection.id}",
                                                    partial: 'connections/error',
                                                    locals: { error_message: e.message })
        end
        raise ActiveRecord::Rollback
      end
    end
  end

  def create
    @connection = current_user.connections.new(connection_params)
    @connector = User.find(connection_params[:connected_user_id])
    respond_to do |format|
      if @connection.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('user-connection-status', partial: 'connections/create',
                                                                              locals: { connector: @connector })
        end
      end
    end
  end

  private

  def connection_params
    params.require(:connection).permit(:user_id, :connected_user_id, :status)
  end
end
