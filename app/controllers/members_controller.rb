class MembersController < OptionsController
	include RestResponseHelper
	def index
		inject_option_headers
		
		if board = get_board(params[:board_id], params)
			success(board.members)
		else
			notFound('No board found')
		end
	end

	def show
		inject_option_headers

		if board = get_board(params[:board_id], params)
			success(board.members.where(id: params[:id]))
		else
			notFound('No board found')
		end

	end
end
