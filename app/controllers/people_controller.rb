class PeopleController < ApplicationController


  def index
    
  
    if params[:search].to_s.blank?
      congresspeople = Sunlight::Legislator.all_for(:address => "123 Fifth Ave New York, NY 10003")
    else
      congresspeople = Sunlight::Legislator.all_for(:address => params[:search])
    end
  
    @senior_senator = congresspeople[:senior_senator]
    @junior_senator = congresspeople[:junior_senator]
    @representative = congresspeople[:representative]
        
    
  end


  def index_sample

       ## Sample
       #################################
      	congresspeople = Sunlight::Legislator.all_for(:address => "123 Fifth Ave New York, NY 10003")
  	
      	# Here is another method to specify location
      	#congresspeople = Sunlight::Legislator.all_for(:latitude => 33.876145, :longitude => -84.453789)
  	
      	senior_senator = congresspeople[:senior_senator]
      	junior_senator = congresspeople[:junior_senator]
      	representative = congresspeople[:representative]

        #Get specifics about the person
      	junior_senator.firstname          # returns "Kirsten" 
      	junior_senator.lastname           # returns "Gillibrand"   
      	junior_senator.congress_office    # returns "531 Dirksen Senate Office Building"
      	junior_senator.phone              # returns "202-224-4451"
  
        ## A method to get members of congress via zip code
        members_of_congress = Sunlight::Legislator.all_in_zipcode(90210)

        ## Loop through those members and do something with it
        	members_of_congress.each do |member|
        		# do stuff
        	end
   
       ## Find based on other fields    
       ##################################################
    
        ## Get all legislators named john
        johns = Sunlight::Legislator.all_where(:firstname => "John")
   
       ## Get all legislators in florida
       	floridians = Sunlight::Legislator.all_where(:state => "FL")
   
       ## Get all male Legislators
       	dudes = Sunlight::Legislator.all_where(:gender => "M")

        ## Loop through all the johns and do something
       	johns.each do |john|
       	  # do stuff
       	end
  
       ###########################################
       ## 
       ## Do a fuzzy search of name (inexact names, John mary could return John Marty)
  	
      	legislators = Sunlight::Legislator.search_by_name("Ed Markey")
       ##  You can specify a higher confidence threshold (default set to 0.80) 
       ##  if you feel that the matches being returned aren’t accurate enough (e.g. .91)
   
      	legislators = Sunlight::Legislator.search_by_name("Johnny Boy Kerry", 0.91)
  
       ###############################################
  
       ## District
       ###############################
   
       #find district by lat and long
       district = Sunlight::District.get(:latitude => 33.876145, :longitude => -84.453789)
       #Find district by address
       district = Sunlight::District.get(:address => "123 Fifth Ave New York, NY")
  
       ## Get state and district number from district
       	district.state            # returns "GA"
       	district.number           # returns "6"

      ## Find all districts in an area specific to a zip code  
    	districts = Sunlight::District.all_from_zipcode(90210)    # returns array of District objects
	
    	## You can loop through the zip codes and get info if needed
    	districts.each do |john|
     	  # do stuff
     	  puts district.state            
       	puts district.number
     	end
	
    	## You can even do the reverse and get the zip from a District
    	zipcodes = Sunlight::District.zipcodes_in("NY", "10")     # returns array of zip codes as strings  ["11201", "11202", "11203",...]

  end
  
  def committees
  
      ## Members of Congress sit on all-important Committees, 
      ## the smaller bodies that hold hearings and are first to review legislation.
      #  The Committee object has three identifying fields, 
      ## and an array of subcommittees, which are Committee objects themselves. 
      ## To get all the committees for a given chamber of Congress:
  
  
      committees = Sunlight::Committee.all_for_chamber("Senate") # or "House" or "Joint"
      some_committee = committees.last
      some_committee.name       # "Senate Committee on Agriculture, Nutrition, and Forestry"
      some_committee.id         # "SSAF"
      some_committee.chamber    # "Senate"

      some_committee.subcommittees.each do |subcommittee|
        # do some stuff...
      end
  
      ## The Committee object also keeps a collection of members in that committee, 
      ## but since that’s an API-heavy call, it must be done for each Committee one at a time:
    
      committees = Sunlight::Committee.all_for_chamber("Senate") # or "House" or "Joint"
       some_committee = committees.last    # some_committee.members starts out as nil
       some_committee.load_members         # some_committee.members is now populated
     
       ## Loop through members and so somthing...
       some_committee.members.each do |legislator|
         # do some stuff...
       end
  
      ## You can find a legislator and all the committees they are on (opposite of above)
       legislators = Sunlight::Legislator.search_by_name("Byron Dorgan")
       legislator = legislators.first
       legislator.committees.each do |committee|
         # do some stuff...
       end
  
  end
  
  #  NOT IMPLEMENTED.....
   
  # def lobby
  # 
  #   ## the confidence threshold defaults to 0.90 instead of 0.80, 
  #   ## More lobbyists mean you want a higher number.
  #   
  #   lobbyists = Lobbyist.search("Nisha Thompsen")
  #   lobbyists = Lobbyist.search("Michael Klein", 0.95, 2007)  
  # 
  #   ## You can also use the Filing object to get a specific filing record, 
  #   ## where the unique identifier comes from the Senate Office of Public Records.
  #   ## http://www.senate.gov/legislative/Public_Disclosure/LDA_reports.htm
  #   ## The Filing object will have an array of issues and lobbyists associated to it.
  #   
  #   filing = Sunlight::Filing.get("29D4D19E-CB7D-46D2-99F0-27FF15901A4C")
  #   
  #   ## Looping through filing issues or lobbyists to do something...
  #   filing.issues.each { |issue|  }
  #   filing.lobbyists.each { |lobbyist| }
  # 
  #   ##  If you have a client name (that is, the organization or company the lobbyist works for) 
  #   ##  or the registrant name (the lobbyist), then you can also find associated filings. 
  #   ##  To use the all_where method, pass in a hash with 
  #   ## :client_name, :registrant_name, and :year as the keys. 
  #   ##  You must pass in :client_name or :registrant_name <---IMPORTANT
  # 
  #   filings = Filing.all_where(:client_name => "SUNLIGHT FOUNDATION")
  #   
  #   filings.each do |filing|
  #     
  #     filing.issues.each { |issue|  }
  #     filing.lobbyists.each { |issue| }    
  #   end
  # 
  # end
  # 
  
end
