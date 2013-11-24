class BoardsController < OptionsController
	include RestResponseHelper

	def index
		inject_option_headers

		# Find the state by the abbreviation
		state, county, city = get_jurisdiction(params[:state_id],params[:county_id],params[:city_id])

		if state && !county && !city
			# render json: {success: true, message: nil, data: state.boards}
			success( state.boards )
		elsif state && county && city || state && city && !county
			# render json: {success: true, message: nil, data: city.boards}
			success( city.boards )
		elsif state && county && !city 
			# render json: {success: true, message: nil, data: county.boards}
			success( county.boards )
		else
			# render json: {success: false, message: 'No response from database', data: []}
			notFound( 'No Response from database' )
		end
	end

	def show
		inject_option_headers

		board = Board.where(id: params[:id]).first
		if board
			# render json: {success: true, message: '', data: board}
			success(board)
		else
			## render json: {success: false, message: 'Board Not Found', data: nil}
			# raise ActionController::RoutingError.new('Not Found')
			notFound( 'Not Found' )

		end
	end

	def update

	end

	def destroy

	end

	def get_jurisdiction(state,county,city)
		state = State.where("lower(abbreviation) = ?", state.downcase ).first
		
		if county
			county = County.where(code_id: county, state_id: state.id)
		else
			county = nil
		end

		if city
			city = City.where(id: city) unless city
		else
			city = nil
		end

		return [state,county,city]
	end
end
