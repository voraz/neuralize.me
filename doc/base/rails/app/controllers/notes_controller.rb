class NotesController < ApplicationController
  # GET /notes
  # GET /notes.xml
  def index
    @notes = Note.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @notes = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @notes = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1/edit
  def edit
    @notes = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @notes = Note.new(params[:notes])

    respond_to do |format|
      if @notes.save
        flash[:notice] = 'Notes was successfully created.'
        format.html { redirect_to(@notes) }
        format.xml  { render :xml => @notes, :status => :created, :location => @notes }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notes.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @notes = Note.find(params[:id])

    respond_to do |format|
      if @notes.update_attributes(params[:notes])
        flash[:notice] = 'Notes was successfully updated.'
        format.html { redirect_to(@notes) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notes.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @notes = Note.find(params[:id])
    @notes.destroy

    respond_to do |format|
      format.html { redirect_to(notes_url) }
      format.xml  { head :ok }
    end
  end
end
