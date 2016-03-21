note
	description: "A game of peg solitaire."
	author: "Nidhi"
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

inherit
	ANY
		redefine
			out
		end

create
	make_from_board,
	make_easy,
	make_cross,
	make_plus,
	make_pyramid,
	make_arrow,
	make_diamond,
	make_skull

feature -- Constructors
	make_from_board (new_board: BOARD)
			-- Initialize a game with 'new_board'.
		do
			board := new_board
		ensure
			board_set:
				board ~ new_board
		end

	make_easy
			-- Initialize a game with easy board.
		do
			create board.make_easy
		ensure
			board_set: board ~ bta.templates.easy_board
		end

	make_cross
			-- Initialize a game with Cross board.
		do

			create board.make_cross
		ensure
			board_set: board ~ bta.templates.cross_board
		end

	make_plus
			-- Initialize a game with Plus board.
		do

			create board.make_plus
		ensure
			board_set: board ~ bta.templates.plus_board
		end

	make_pyramid
			-- Initialize a game with Pyramid board.
		do

			create board.make_pyramid
		ensure
			board_set:
				board ~ bta.templates.pyramid_board
		end

	make_arrow
			-- Initialize a game with Arrow board.
		do

			create board.make_arrow
		ensure
			board_set: board ~ bta.templates.arrow_board
		end

	make_diamond
			-- Initialize a game with Diamond board.
		do

			create board.make_diamond
		ensure
			board_set:
				board ~ bta.templates.diamond_board
		end

	make_skull
			-- Initialize a game with Skull board.
		do
			--make_easy
			create board.make_skull
		ensure
			board_set: board ~ bta.templates.skull_board
		end

feature -- Commands
	move_left (r, c: INTEGER)
		require
			from_slot_valid_row:
				board.is_valid_row (r)
			from_slot_valid_column:
				board.is_valid_column (c)
			middle_slot_valid_column:
				board.is_valid_column (c - 1)
			to_slot_valid_column:
				board.is_valid_column (c - 2)
			from_slot_occupied:
				board.status_of (r,c) = board.occupied_slot
			middle_slot_occupied:
				board.status_of (r,c - 1) = board.occupied_slot
			to_slot_unoccupied:
				board.status_of (r,c - 2) = board.unoccupied_slot
		do
			-- Set the far left one as occupied and the other two unoccupied
			board.set_status (r,c - 2,board.occupied_slot)
			board.set_statuses (r, r, c - 1, c, board.unoccupied_slot)
		ensure
			slots_properly_set:
				board.status_of (r, c - 2) = board.occupied_slot
			and board.status_of (r, c - 1) = board.unoccupied_slot
			and board.status_of (r, c)   = board.unoccupied_slot
			other_slots_unchanged:
				board.matches_slots_except (board, r, r, c - 2, c)
		end

	move_right (r, c: INTEGER)
		require
			from_slot_valid_row:
				board.is_valid_row (r)
			from_slot_valid_column:
				board.is_valid_column (c)
			middle_slot_valid_column:
				board.is_valid_column (c + 1)
			to_slot_valid_column:
				board.is_valid_column (c + 2)
			from_slot_occupied:
				board.status_of (r,c) = board.occupied_slot
			middle_slot_occupied:
				board.status_of (r,c + 1) = board.occupied_slot
			to_slot_unoccupied:
				board.status_of (r,c + 2) = board.unoccupied_slot
		do
			-- Set the far rigt one as occupied and the other two unoccupied
			board.set_status (r,c + 2,board.occupied_slot)
			board.set_statuses (r, r, c, c + 1, board.unoccupied_slot)
		ensure
			slots_properly_set:
				board.status_of (r, c + 2) = board.occupied_slot
			and board.status_of (r, c + 1) = board.unoccupied_slot
			and board.status_of (r, c)   = board.unoccupied_slot
			other_slots_unchanged:
				board.matches_slots_except (board, r, r, c, c + 2)
		end

	move_up (r, c: INTEGER)
		require
			from_slot_valid_column:
				board.is_valid_column (c)
			from_slot_valid_row:
				board.is_valid_row (r)
			middle_slot_valid_row:
				board.is_valid_row (r - 1)
			to_slot_valid_row:
				board.is_valid_row (r - 2)
			from_slot_occupied:
				board.status_of (r,c) = board.occupied_slot
			middle_slot_occupied:
				board.status_of (r - 1,c) = board.occupied_slot
			to_slot_unoccupied:
				board.status_of (r - 2,c) = board.unoccupied_slot
		do
			-- Set the top up one as occupied and the other two unoccupied
			board.set_status (r - 2,c,board.occupied_slot)
			board.set_statuses (r - 1, r, c, c, board.unoccupied_slot)
		ensure
			slots_properly_set:
				board.status_of (r - 2, c) = board.occupied_slot
			and board.status_of (r - 1, c) = board.unoccupied_slot
			and board.status_of (r, c)   = board.unoccupied_slot
			other_slots_unchanged:
				board.matches_slots_except (board, r-1, r, c, c)
		end

	move_down (r, c: INTEGER)
		require
			from_slot_valid_column:
				board.is_valid_column (c)
			from_slot_valid_row:
				board.is_valid_row (r)
			middle_slot_valid_row:
				board.is_valid_row (r+1)
			to_slot_valid_row:
				board.is_valid_row (r+2)
			from_slot_occupied:
				board.status_of (r,c) = board.occupied_slot
			middle_slot_occupied:
				board.status_of (r+1,c) = board.occupied_slot
			to_slot_unoccupied:
				board.status_of (r+2,c) = board.unoccupied_slot
		do
			-- Set the top down one as occupied and the other two unoccupied
			board.set_status (r+2,c,board.occupied_slot)
			board.set_statuses (r, r+1, c, c, board.unoccupied_slot)
		ensure
			slots_properly_set:
				board.status_of (r+2, c) = board.occupied_slot
			and board.status_of (r+1, c) = board.unoccupied_slot
			and board.status_of (r, c)   = board.unoccupied_slot
			other_slots_unchanged:
				board.matches_slots_except (board, r, r + 1, c, c)
		end

feature -- Status Queries

	is_over: BOOLEAN
			-- Is the current game 'over'?
			-- i.e., no further movements are possible.
		do
			Result := not
			across 1 |..| board.number_of_rows as i some              -- if there exists some position (r, c) that is movable in the board, then the game is not over
				across 1 |..| board.number_of_columns as j some
					moves (i.item,j.item)
				end
			end
		ensure
			correct_result:
				Result = not
		     	across 1 |..| board.number_of_rows as i some
				   across 1 |..| board.number_of_columns as j some
				     moves (i.item,j.item)
				end
			end
		end

	is_won: BOOLEAN
			-- Has the current game been won?
			-- i.e., there's only one occupied slot on the board.
		do
			Result := is_over and board.number_of_occupied_slots = 1  -- the game should be over in order to win and there is only one peg left
		ensure
			game_won_iff_one_occupied_slot_left:
				Result implies (board.number_of_occupied_slots = 1) and
				not (board.number_of_occupied_slots = 1) implies not Result
			winning_a_game_means_game_over:
				Result implies is_over and
				not is_over implies not Result
		end

	moves(r,c : INTEGER) : BOOLEAN

		   local
		    left_move : BOOLEAN
			right_move : BOOLEAN
			up_move : BOOLEAN
			down_move : BOOLEAN
			up,down,left,right : BOOLEAN
		   do

		   		left_move:= board.is_valid_column (c - 2)
				right_move:= board.is_valid_column (c + 2)
				up_move:= board.is_valid_row (r - 2)
				down_move:= board.is_valid_row (r + 2)

				if left_move then                                               -- To check if it is movable to the left
					left := board.status_of (r,c) = board.occupied_slot and
						board.status_of (r,c - 1) = board.occupied_slot and
						board.status_of (r,c - 2) = board.unoccupied_slot
				end
				if right_move then                                            -- To check if it is movable to the right
					right := board.status_of  (r,c) = board.occupied_slot and
						board.status_of (r,c + 1) = board.occupied_slot and
						board.status_of (r,c + 2) = board.unoccupied_slot
				end
				if up_move then                                               -- To check if it is movable upwards
					up := board.status_of (r,c) = board.occupied_slot and
						board.status_of (r - 1,c) = board.occupied_slot and
						board.status_of (r - 2,c) = board.unoccupied_slot
				end
				if down_move then                                             -- To check if it is movable downwards
					down := board.status_of (r,c) = board.occupied_slot and
						board.status_of (r + 1,c) = board.occupied_slot and
						board.status_of (r + 2,c) = board.unoccupied_slot
				end
				Result := (up or down or left or right)


		   end

feature -- Output
	out: STRING
			-- String representation of current game.
			-- Do not modify this feature!
		do
			create Result.make_empty
			Result.append ("Game is over: " + boolean_to_yes_no (is_over) + "%N")
			Result.append ("Game is won : " + boolean_to_yes_no (is_won) + "%N")
			Result.append ("Board Status:%N")
			Result.append (board.out)
		end

feature -- Auxiliary Routines
	boolean_to_yes_no (b: BOOLEAN): STRING
			-- 'Yes' or 'No' corresponding to 'b'.
		do
			if b then
				Result := "Yes"
			else
				Result := "No"
			end
		end

feature -- Board
	bta: BOARD_TEMPLATES_ACCESS
	board: BOARD
end
