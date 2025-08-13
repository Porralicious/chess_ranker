class MembersController < ApplicationController
    before_action :set_member, only: %i[show edit update destroy]

    def index
        @members = Member.order(:current_rank)
    end

    def show
    end

    def new
        @member = Member.new
    end

    def create
        @member = Member.new(member_params)
        @member.current_rank = Member.count + 1
        if @member.save
            redirect_to @member, notice: "New member was successfully created."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @member.update(member_params)
            redirect_to @member, notice: 'Member was successfully updated.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @member.destroy
        redirect_to members_url, notice: "Member was successfully deleted."
    end

    private

    def set_member
        @member = Member.find(params[:id])
    end

    def member_params
        params.require(:member).permit(:name, :surname, :email, :birthday, :number_of_club_games_played, :current_rank)
    end
end