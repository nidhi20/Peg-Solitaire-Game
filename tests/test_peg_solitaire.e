

note
	description: "Tests on peg solitaire games."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PEG_SOLITAIRE

inherit
	ES_TEST

create
	make

feature -- Constructor
	make
		do
			add_boolean_case (agent test_easy_game_creation)
			add_boolean_case (agent test_move_left)
			add_boolean_case (agent test_game_win)
			add_boolean_case (agent test_peg_movable)
			add_boolean_case(agent test_isequal_feature)
			add_violation_case(agent test_validity)
			add_boolean_case(agent test_number_of_occupied_slots)
			add_boolean_case(agent test_singleton)

		end

feature -- Templates
	bta: BOARD_TEMPLATES_ACCESS

feature -- Tests of Creation
	test_easy_game_creation: BOOLEAN
		local
			g: GAME
		do
			comment ("test: game creation with easy board")
			create g.make_easy
			Result :=
					g.board ~ bta.templates.easy_board
				and not g.is_over
				and not g.is_won
			check Result end

			Result := g.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			***.***
			***O***
			***O***
			***.***
			***O***
			***.***
			*******
			]"
			check Result end
		end

test_move_left: BOOLEAN  -- to test my feature move_left from GAME class
local
g: GAME
b: BOARD
do
	comment("test: to test feature move_left from GAME class")
	create g.make_cross
	g.move_left (3, 4)
	b := g.board
	Result := b.status_of (3, 4) = b.unoccupied_slot
	check Result end

	Result := b.status_of (3, 3) = b.unoccupied_slot
	check Result end

	Result := b.status_of (3, 2) = b.occupied_slot
	check Result end

	Result:= b.matches_slots_except (b, 3, 3, 2, 4)
	check Result end
end

test_game_win: BOOLEAN   -- to test feature is_won from GAME class
local
	g:GAME
do
	comment("test: to test feature is_won from GAME class")
	create g.make_easy
	g.move_down (2, 4)  --here I test move down
	g.move_up (5,4)     --here I test move up
	Result := g.is_won
	check Result end
end

test_peg_movable: BOOLEAN
local
	 g: GAME
do
	comment("test: to check if the peg at a particular location is movable")
	create g.make_pyramid
	Result := g.moves (4, 3)  -- the position (4, 3) in the board pyramid is movable
	check Result end
	Result := not g.moves (4, 2) -- the position (4, 2) in the board pyramid is not movable
	check Result end
end



test_isequal_feature: BOOLEAN
local

	b1, b2, b3: BOARD
do
	comment("test: is_equal feature in BOARD class")
	create b1.make_easy
	create b2.make_plus
	create b3.make_easy
	Result := not b1.is_equal (b2)
	check Result end
	Result := b1.is_equal (b3)
end

test_validity
local
	b: BOARD
	s: SLOT_STATUS
do
	comment("test: to test the validity of a feature")
	create b.make_diamond
	s := b.status_of (8, 9) -- since column 8 does not exist it throws a violation. This is why we used add_violation_cas
end

test_number_of_occupied_slots: BOOLEAN
local
	b: BOARD
do
	comment("test: to check the number_of_occupied_slots feature in BOARD class")
	create b.make_default
	Result:= b.number_of_occupied_slots = 0
	check Result end

	create b.make_easy
	Result:= b.number_of_occupied_slots = 3
	check Result end
end

test_singleton: BOOLEAN
local
	s: SLOT_STATUS_ACCESS
	s1: SLOT_STATUS
	s2: SLOT_STATUS
	do
		comment("test: singleton status of SLOT_STATUS_ACCESS class")
		s1 := s.unoccupied_slot
		s2 := s.unoccupied_slot
		Result := s1 = s2
	end

end
