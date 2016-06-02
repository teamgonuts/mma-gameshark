class MmaEventsController < ApplicationController
  before_action :set_mma_event, only: [:show, :edit, :update, :destroy]

  # GET /mma_events
  # GET /mma_events.json
  def index
    @mma_events = MmaEvent.all
  end

  # GET /mma_events/1
  # GET /mma_events/1.json
  def show
  end

  # GET /mma_events/new
  def new
    @mma_event = MmaEvent.new
  end

  # GET /mma_events/1/edit
  def edit
  end

  # POST /mma_events
  # POST /mma_events.json
  def create
    @mma_event = MmaEvent.new(mma_event_params)

    respond_to do |format|
      if @mma_event.save
        format.html { redirect_to @mma_event, notice: 'Mma event was successfully created.' }
        format.json { render :show, status: :created, location: @mma_event }
      else
        format.html { render :new }
        format.json { render json: @mma_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mma_events/1
  # PATCH/PUT /mma_events/1.json
  def update
    respond_to do |format|
      if @mma_event.update(mma_event_params)
        format.html { redirect_to @mma_event, notice: 'Mma event was successfully updated.' }
        format.json { render :show, status: :ok, location: @mma_event }
      else
        format.html { render :edit }
        format.json { render json: @mma_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mma_events/1
  # DELETE /mma_events/1.json
  def destroy
    @mma_event.destroy
    respond_to do |format|
      format.html { redirect_to mma_events_url, notice: 'Mma event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mma_event
      @mma_event = MmaEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mma_event_params
      params.require(:mma_event).permit(:organization, :name, :date, :location, :event_link)
    end
end
