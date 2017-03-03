=begin
line = File.open('weather.dat', File::RDONLY){|f| f.read }
=end
header = []
readarray = []
count = 0
daynumber = 0
smallesttempspread = 200
daycolumn = 0
maxcolumn = 0
mincolumn = 0
smallcount = 0

IO.foreach("weather.dat") do |line| 
  # Use split to get attributes
  if count == 0 #if this is the first row, it will be the header
    header = line.strip.split(" ")#trip the line of /n characters and split header items into array
    #p header
    header.each do |column|#for each item in header
      #Go through the header array and find the coloumns containing the day, max, and min temperatures
      if column == "Dy"        #if the element = "Dy"
        daycolumn = smallcount #keep that element number for day
        #p "Day column: "+daycolumn.to_s
      end
      if column == "MxT"       #if the element = "MxT"
        maxcolumn = smallcount #keep that element number for max
        #p "Maximum column: "+maxcolumn.to_s
      end
      if column == "MnT"       #if the element = "MnT"
        mincolumn = smallcount #keep that element number for min
        #p "Minimum column: "+mincolumn.to_s
      end      
      smallcount += 1
    end
  else
    #now that the header is done, read in each row, one by one
    readarray = line.strip.split(" ") #strip the line of /n characters and split line items into an array
    #check for a nil list
    #if readarray[0] != nil # or readarray.length >= 1
    #  p readarray
    #end
    #eliminate the nil row and the last row
    if (readarray[0] != nil)&&(readarray[0] != "mo") #this should eliminate the two strange lines in the .dat file
      #p "[ "+readarray[0]+", "+readarray[1]+", "+readarray[2]+" ]"
      #subtract the min from the max, and see if it's smaller than the current smallest temp spread
      if ((readarray[maxcolumn].to_i) - (readarray[mincolumn].to_i)) < smallesttempspread
        #if it is smaller, record the day number, and the temperature spread
        smallesttempspread = ((readarray[maxcolumn].to_i) - (readarray[mincolumn].to_i))
        daynumber = readarray[0]
      end      
    end  
  end
  count += 1
end
#print the outcome
p "Calculate the smallest daily temperature variance from the month in the weather.dat file:"
p "Day of the month with the smallest temperature spread: day "+daynumber.to_s
p "Smallest temperature spread: "+smallesttempspread.to_s+ " degrees"

