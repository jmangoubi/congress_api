class InfluenceController < ApplicationController
  
  
  def index
  
    ## Find contribtions by a person
    unless params[:search].to_s.blank?
      @contributions = TransparencyData::Client.contributions(:contributor_ft => params[:search])
      @person=params[:search]
    else
      @contributions = TransparencyData::Client.contributions(:contributor_ft => 'steve jobs')
      @person="steve jobs"
    end
  
  end
  
  
  
  def index_samples
  
    ##API INFORMATION
    ## http://data.influenceexplorer.com/api/?r
    
    
    ## Find contribtions by a person
    contributions = TransparencyData::Client.contributions(:contributor_ft => 'steve jobs')
    
    contributions.each do |contribution|
      puts "Amount: #{contribution.amount}"
      puts "Date: #{contribution.date}"
    end

    ## Find lobbying by an organization
    lobbyings = TransparencyData::Client.lobbying(:client_ft => "apple inc")
   
   
    lobbyings.each do |lobbying|
      puts "Amount: #{lobbying.amount}"
      puts "Year: #{lobbying.year}"
    end
  
    # contributions with an amount greater than or equal to $1000
    TransparencyData::Client.contributions(:contributor_ft => 'steve jobs', :amount => {:gte => 1000})

    # contributions with an amount less than or equal to $500
    TransparencyData::Client.contributions(:contributor_ft => 'bill gates', :amount => {:lte => 500})

    # contributions in the 2006 or 2008 cycle
    TransparencyData::Client.contributions(:contributor_ft => 'eric schmidt', :cycle => [2006,2008])

    # contributions to Obama made between in Q1 2008
    TransparencyData::Client.contributions(:recipient_ft => 'barack obama',
                                           :date => {:between => ['2008-01-01','2008-03-31']})
  
  
  
  
  end
end
