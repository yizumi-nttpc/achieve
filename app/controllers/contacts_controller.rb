class ContactsController < ApplicationController
  def index
  end

  def create
    @contact = Contact.create(contacts_params)

    if @contact.save
      flash[:success] = "お問い合わせが完了しました！"
      redirect_to root_path
      NoticeMailer.sendmail_contact(@contact).deliver
    else
      render 'new'
    end
  end

  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end

  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end

  private
    def contacts_params
      params.require(:contact).permit(:name, :email, :content)
    end

end
