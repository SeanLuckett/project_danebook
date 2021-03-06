class LikedResource
  attr_reader :record, :type

  def initialize(params)
    @type = params[:likable]
    @params_resource_id = "#{@type.downcase}_id".to_sym

    @record = @type.constantize.find(params[@params_resource_id])
  end

  def user
    @type == 'Comment' ? @record.commentable.user : @record.user
  end
end