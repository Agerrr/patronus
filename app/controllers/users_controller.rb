class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def update
	end

	def create
	end

	def index
		@users = User.all
	end
	
end