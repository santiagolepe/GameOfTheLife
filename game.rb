class Game

	def initialize

		@rows = 20
		@cols = 20
		@step = 0
		
		puts "\e[H\e[2J...:: GaMe oF ThE LiFe ::...\n\n"
		puts "1.- Glinder     2.- Block    3.- Blinker    4.-Pulsar   5.-Custom random \n\n"
		puts "Choose option:"

		option = gets.to_i

		#start the game
		run(option)
	end

	def run(option)

		#create grid
		@grid = createGrid

		#patterns
		glider = [[5,1], [5,2], [5,3], [4,3], [3,2]]
		block = [[3,7], [3,8], [4,7], [4,8]]
		blinker = [[1,2], [2,2], [3,2]]
		pulsar = [[2,5],[2,6],[2,7],[2,11],[2,12],[2,13],
				  [7,5],[7,6],[7,7],[7,11],[7,12],[7,13],
				  [9,5],[9,6],[9,7],[9,11],[9,12],[9,13],
				  [14,5],[14,6],[14,7],[14,11],[14,12],[14,13],
				  [4,3],[5,3],[6,3],[10,3],[11,3],[12,3],
				  [4,8],[5,8],[6,8],[10,8],[11,8],[12,8],
				  [4,10],[5,10],[6,10],[10,10],[11,10],[12,10],
				  [4,15],[5,15],[6,15],[10,15],[11,15],[12,15]]

		case option
		when 1
			setCels (glider)
			title = "..:: G L I N D E R ::.."
		when 2
			setCels (block)
			title = "..:: B L O C K ::.."
		when 3
			setCels (blinker)
			title = "..:: B L I N K E R  ::.."
		when 4
			setCels (pulsar)
			title = "..:: P U L S A R ::.."
		when 5
			setRnd
			title = "..:: C U S T O M   ::  R A N D O M ::.."
		else
			setRnd
			title = "..:: C U S T O M   ::  R A N D O M ::.."
		end

	
		while 1 > 0
			#clear screen
			puts "\e[H\e[2J #{title}"
			
			#print grid
			printGrid

			puts "\n\nStep : #{@step}"

			#check rules
			check
			@step += 1
			sleep 0.2
		end
	end

	def check
		grid = createGrid
		@grid.each_with_index do |row, y|
			row.each_with_index do |cell, x|
				if @rows+2 > x and @cols+2 > y
					count = countNeighbors(x, y)
					#puts "#{count} #{x} _ #{y} _cell #{cell}"
					if cell == 1
						if count == 2 or count == 3
							grid[y][x] = 1
						else
							grid[y][x] = 0
						end
					else
						if count == 3
							grid[y][x] = 1
						else
							grid[y][x] = 0
						end
					end
				end
			end
		end
		@grid = grid
	end

	def countNeighbors(x, y)
		count = 0
		(-1..1).each do |a|
			(-1..1).each do |b|
				unless (a==0) and (b==0)
					if @grid[y+a][x+b] == 1
						count += 1
					end
				 end 
			end
		end
		count
	end

	def printGrid
		@grid.each_with_index do |row, y|
			row.each_with_index do |cell, x|
				if @rows > x and @cols > y
					if cell == 1
						print "o"
					else
						print " "
					end
					
					if x == @rows - 1
						print "\n"

					end
				end
			end
		end
	end

	def createGrid
		Array.new(@rows+4) { Array.new(@cols+4, 0) }
	end

	def setCels(cells)
		cells.each {|y,x| @grid[y][x] = 1}
	end

	def setRnd
		@grid.each_with_index do |row, y|
			row.each_with_index do |cell, x|
				if @rows+2 > x and @cols+2 > y
					@grid[y][x] = rand(2)
				end
			end
		end
	end

end

if $0 == __FILE__
	game = Game.new
end
