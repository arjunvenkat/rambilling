class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json

  def list
    @unbilled_tasks = @current_user.tasks.where(status: 'unbilled')
    @billed_tasks = @current_user.tasks.where(status: 'billed')
    @task = Task.new
    @clients = @current_user.clients
    @page = 'tasks'
  end

  def edit_status
    task = Task.find(params[:id])
    task.status = params[:status]
    task.save
    if params[:coming_from] == 'index'
      redirect_to tasks_url
    else
      redirect_to tasks_list_url
    end
  end

  def index
    @recent_tasks = @current_user.tasks.where(status: 'unbilled').limit(10)
    @task = Task.new
    @projects = Project.all
    @project = Project.new
    @clients = @current_user.clients
    @client = Client.new
    @page = 'home'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @clients = Client.all
    @projects = Project.all
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'created' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { redirect_to tasks_url, notice: 'error' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'deleted' }
      format.json { head :no_content }
    end
  end
end
