class EventsController < ApplicationController
	before_action :set_event, :only => [ :show, :edit, :update, :destroy ]

	def index
		@event = Event.new
		@events = Event.page(params[:page]).per(10)



		respond_to do |format|
		    format.html # index.html.erb
		    format.xml { render :xml => @events.to_xml }
		    format.json { render :json => @events.to_json }
		    format.atom { @feed_title = "My event list" } # index.atom.builder
		end    

 
	end

	def new
		@event = Event.new
	end

	def create
	  
	  @event = Event.new(event_params)
	  @event.save

	  if @event.save
	  	flash[:notice] = "event was successfully created"
	    redirect_to events_path
	  else
	    render :action => :new
	  end

	end

	def show
  		@page_title = @event.name

  		  respond_to do |format|
		    format.html { @page_title = @event.name } # show.html.erb
		    format.xml # show.xml.builder
		    format.json { render :json => { id: @event.id, name: @event.name }.to_json }
		  end
	end

	def edit
	end

	def update

  		@event.update(event_params)

  		  if @event.update(event_params)
  		  	flash[:notice] = "event was successfully updated"
		    redirect_to event_path(@event)
		  else
		    render :action => :index
		  end
	end

	def destroy
	  @event.destroy
	  flash[:alert] = "event was successfully deleted"
	  redirect_to events_path
	end

	def set_event
  	@event = Event.find(params[:id])
	end

	private

	def event_params
	  params.require(:event).permit(:name, :description)
	end

end
