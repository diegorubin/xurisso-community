module FormResponse

  def update
    if get_object_variable.update(send("#{resource_name}_params"))

      if params[:xhr]
        render json: {
          resource: get_object_variable, 
          message: I18n.t('form_response.messages.success')
        }
      else
        flash[:notice] = I18n.t('form_response.messages.success')
        redirect_to :action => :show, :id => get_object_variable.login
      end

    else

      if params[:xhr]
        render status: 422,
        json: {
          resource: get_object_variable, 
          errors: get_object_variable.errors, 
          message: I18n.t('form_response.messages.failed')
        }
      else
        flash[:notice] = I18n.t('form_response.messages.failed')
        render :action => :edit
      end

    end
  end

end

