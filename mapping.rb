=begin

        Created by Harry A. Swan
        Mapping program

        A program that allows the user to create a map of any size and set different areas to different terrains
        and allowing the user to display the map

        Last edit: 20th April 2016 @ 23:50
=end

class BaseMap                                   #BaseMap will be the core object that holds the map
    def initialize(x, y)                        #The initialize method is called on the creation of the object - it sets the size and creates the array
        @size = [x, y]          #store the size of the map
        @map = setArray(x,y)    #setup the array to store the map values in
        setArea(0, 0, @size[0], @size[1], 0) #set all the map points to 0 (the default value)
    end

    def setArray(x,y)                           #setArray creates the array that will be used to store the details of each point in the map
        a = Array.new(x)    #create an array of size x
        a.map! { Array.new(y) } #create a subarray of size y inside every array element
        return a
    end

    def setArea(x, y, w, h, ter)                #setArea sets a specific area of the map to a new terrain value, by calling setPoint
        if (x+w) <= @size[0] && (y+h) <= @size[1]   #check the area is within the map bouderies
            for xSize in x...(x+w)
                for ySize in y...(y+h)
                    setPoint(xSize, ySize, ter)
                end
            end
        end
    end

    def setPoint(x, y, ter)                     #setPoint sets a single point on the map to a new terrain value
        @map[x][y] = ter
    end

    def getTer(x, y)                            #getTer returns the value of the map at the specified point
        return @map[x][y]
    end

    def getXSize                                #getXSize returns the x size of the map
        return  @size[0]
    end

    def getYSize                                #getYSize return the y soze of the map
        return  @size[1]
    end

end #end of BaseMap Class

class TerrainValues                             #TerrainValues is an object that will aid in the "humifying" of the terrain codes stored in the map

    def initialize                              #initialize sets up the terrain array with the current terrains avaliable
        @terrain = [["Grass", "G"],["Rock", "R"],["Water", "W"],["Trees","T"],["Sand","S"]]
    end

    def getVal(code)                            #getVal returns the single letter notation of the specified terrain code
        return @terrain[code][1]
    end
    def getName(code)                           #getName returns the name of the terrain that matches specified terrain code
        return @terrain[code][0]
    end
    def getNumOfTer                             #getNumOfTer returns the number of terrains currently avaliable
        count = -1
        @terrain.each do |item|
            count += 1
        end
        count
    end
end #end of TerrainValues Class

class ConsoleUI                                 #ConsoleUI is the object that will govern the way the user interacts with the program

    def initialize                              #initialize delares the map and the terrain objects that are required to run the program
        @theMap = nil
        @terrains = TerrainValues.new
    end

    def createMap                               #createMap will call the user to input 2 Integers and create the map to the specified size

        puts "Please set the width of the map:"
        userW = gets.chomp.to_i

        puts "Please set the height of the map:"
        userH = gets.chomp.to_i

        @theMap = BaseMap.new(userW, userH)
        puts "Map created with a size of #{userW} by #{userH}"
    end

    def setArea                                 #setArea will ask the user for (X,Y) position, width & height and a terrain value and set the corrosponding area of the map as such
        puts "Please set the x position of the area:"
        userX = gets.chomp.to_i

        puts "Please set the y position of the area:"
        userY = gets.chomp.to_i

        puts "Please set the width of the area:"
        userW = gets.chomp.to_i

        puts "Please set the height of the area:"
        userH = gets.chomp.to_i

        puts "Please set the terrain value for the area:"
        userTer = gets.chomp.to_i

        @theMap.setArea(userX, userY, userW, userH, userTer)
        puts "Map area with a size of #{userW} by #{userH} at point (#{userX},#{userY})"
    end

    def drawMap                                 #drawMap will draw the map in it's current form to the console, the terrains being represented as their single letter notation

        puts "Your map currently looks like:"

        for i in 0...@theMap.getXSize
            print "-"
        end
        print "\n"

        if @theMap != nil
            for yLoop in (@theMap.getYSize - 1).downto(0)
                for xLoop in 0...@theMap.getXSize
                    print @terrains.getVal(@theMap.getTer(xLoop, yLoop))
                end
                print "\n"
            end
        end

        for i in 0...@theMap.getXSize
            print "-"
        end
        print "\n"

    end

    def printHelp                               #printHelp will print the help menu to the screen for the user to see
        puts "createmap     :used to create the map"
        puts "setarea       :used to set an area of the map to a terrain"
        #puts "setborder     :used to set the border area of the map to a terrain"
        puts "drawmap       :used to draw the map to the console"
        puts "terrains      :used to print the terrains and their codes to the console"
        puts "help          :used to print this menu to the console"
        puts "exit          :used to close the program"
        puts ""
        puts "Please note: any input that is expecting an Integer will be converted to 0 if a string is given"
    end

    def printTerrainValues                      #printTerrainValues will print out the currently avaliable terrains for the user to see

        puts "Terrain values are as follows:"
        puts "| Code  | Name  | Symbol    |"
        for i in 0..@terrains.getNumOfTer
            puts "| #{i}    | #{@terrains.getName(i)}   | #{@terrains.getVal(i)}    |"
        end
    end

    def getInput                                #getInput when called will request an input from the user and will action it if possible
        puts "Input:"
        input = gets.chomp  #grab user  input
        case input          #try to find a matching command to the users input and call the relevent method
        when "createmap"
            createMap
        when "setarea"
            setArea
        #when "setborder"
            #setBorder
        when "drawmap"
            drawMap
        when "terrains"
            printTerrainValues
        when "help"
            printHelp
        when "exit", "end"
            return false    #returning false tells the program the user no longers wishes to run the pogram so therefore should terminate
        else                #failing to find a matching command will print the help menu automaticly to try and aid the user
            puts "Not a recognised command...."
            printHelp
        end
        return true
    end

end #end of ConsoleUI Class

running = true              #running is a boolean that will stay true until the user decides to terminate the program
consoleUI = ConsoleUI.new   #setting up the console interface of the program

puts "This program was created by Harry A. Swan" #just saying hello
consoleUI.printHelp         #printing the help menu at start informing the user of how to use the program

while running                                   #this loop allows to program to continue running until the user decides to end it (by setting running to false)

    if !consoleUI.getInput  #if after the user has completed am input to the program they have chosen to end the program......
        running = false     #set running to false
    end

end #end of the main program loop

puts "Goodbye...."         #a small goodbye
