class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def file_import
    csv_file = (params[:file])
    sheet = Roo::Spreadsheet.open(csv_file.path)
    header = sheet.row(1)
    (2..sheet.last_row).each do |i|
      row = Hash[[header, sheet.row(i)].transpose]
      User.create(file:row)
    end
    redirect_to root_url, notice: 'File imported.'
  end

  def update
    @user.file['Pri'] = params[:user][:Pri] if params[:user][:Pri].present?
    @user.file['Question'] = params[:user][:Question] if params[:user][:Question].present?
    @user.file['Teaming Stages'] = params[:user][:Teaming] if params[:user][:Teaming].present?
    @user.file['Appears (Day)'] = params[:user][:Appears] if params[:user][:Appears].present?
    @user.file['Frequency'] = params[:user][:Frequency] if params[:user][:Frequency].present?
    @user.file['Type'] = params[:user][:Type] if params[:user][:Type].present?
    @user.file['Role'] = params[:user][:Role] if params[:user][:Role].present?
    @user.file['Required?'] = params[:user][:Required?] if params[:user][:Required?].present?
    @user.file['Conditions'] = params[:user][:Conditions] if params[:user][:Conditions].present?
    @user.file['Mapping'] = params[:user][:Mapping] if params[:user][:Mapping].present?
    @user.save!
    redirect_to root_url

  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

end
