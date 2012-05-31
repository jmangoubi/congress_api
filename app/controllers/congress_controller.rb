class CongressController < ApplicationController
  
  
  def index
  
    # Fetch bills introduced bills and resolutions in Congress
    # Your can search based on parameters.. Congress.bills(:search => "education")
    # More info at : http://services.sunlightlabs.com/docs/Real_Time_Congress_API/
    
     @bill_fields = %w[bill_id bill_type number code session chamber abbreviated]
     
     @bills = Congress.bills
     
    
    # Fetch votes taken in Congress
    # @votes = Congress.votes

    # Fetch amendments to bills and resolutions offered in Congress
   #  @amendments = Congress.amendments

    # Fetch videos from the U.S. House of Representatives and from the White House
    
    ## Error with videos  DISABLED
    # @videos = Congress.videos

    # Fetch updates from the floor of each chamber of Congress
  #   @floor_updates = Congress.floor_updates

    # Fetch upcoming scheduled committee hearings in the House and Senate
  #   @committee_hearings = Congress.committee_hearings

    # Fetch links to various kinds of documents produced by agencies within Congress
   #  @documents = Congress.documents
  
  end
  
end
