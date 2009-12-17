class DisciplinesController < ApplicationController
  # GET /disciplines
  # GET /disciplines.xml
  def index
    @disciplines = Discipline.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @disciplines }
    end
  end

  # GET /disciplines/1
  # GET /disciplines/1.xml
  def show
    @disciplines = Discipline.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @disciplines }
    end
  end

  # GET /disciplines/new
  # GET /disciplines/new.xml
  def new
    @disciplines = Discipline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @disciplines }
    end
  end

  # GET /disciplines/1/edit
  def edit
    @disciplines = Discipline.find(params[:id])
  end

  # POST /disciplines
  # POST /disciplines.xml
  def create
    @disciplines = Discipline.new(params[:disciplines])

    respond_to do |format|
      if @disciplines.save
        flash[:notice] = 'Disciplines was successfully created.'
        format.html { redirect_to(@disciplines) }
        format.xml  { render :xml => @disciplines, :status => :created, :location => @disciplines }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @disciplines.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /disciplines/1
  # PUT /disciplines/1.xml
  def update
    @disciplines = Discipline.find(params[:id])

    respond_to do |format|
      if @disciplines.update_attributes(params[:disciplines])
        flash[:notice] = 'Disciplines was successfully updated.'
        format.html { redirect_to(@disciplines) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @disciplines.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplines/1
  # DELETE /disciplines/1.xml
  def destroy
    @disciplines = Discipline.find(params[:id])
    @disciplines.destroy

    respond_to do |format|
      format.html { redirect_to(disciplines_url) }
      format.xml  { head :ok }
    end
  end
end
