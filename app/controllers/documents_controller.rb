class DocumentsController < AuthenticatedController
  before_filter :get_client

  def index
    if params[:path]
      @files = get_path(params[:path], true)

      @items = current_user.items.sort_by(&:name)
    else
      @files = get_path("/", false)
    end
  end

  private

  def get_client
    s = DropboxSession.deserialize(current_user.dropbox_session)

    @client = DropboxClient.new(s, :app_folder)
  end

  def get_path(folder, media_flag)
    files = []

    Rails.logger.debug("Walking #{folder}")

    metadata = @client.metadata(folder)

    unless metadata['contents']
      metadata['media_link'] = @client.media(metadata['path'])['url']
      return [metadata]
    end

    metadata['contents'].each do |file|
      if file['is_dir']
        files = files | get_path(file['path'])
      else
        files << file
      end
    end

    files
  end
end