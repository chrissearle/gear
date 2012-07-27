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

  def create
    params[:items].each do |item_id|
      item = current_user.items.find(item_id)

      if item
        document = Document.new
        document.path = params[:path]
        document.doctype_list = params[:tag]

        document.item = item

        document.save
      end
    end

    redirect_to documents_url, notice: t('links.created.ok')
  end

  def destroy
    document = Document.find(params[:id])

    item = document.item

    if item.user == current_user
      document.destroy

      redirect_to item_path(item), notice: t('document.deleted')
    else
      redirect_to item_path(item), error: t('document.not.owner')
    end

  end

  private

  def get_client
    @client = current_user.get_client
  end

  def get_path(folder, media_flag)
    files = []

    Rails.logger.debug("Walking #{folder}")

    metadata = @client.metadata(folder)

    if metadata['contents']
      metadata['contents'].each do |file|
        if file['is_dir']
          files = files | get_path(file['path'], media_flag)
        else
          files << file
        end
      end
    else
      if media_flag
        metadata['media_link'] = @client.media(metadata['path'])['url']
      end
      files = [metadata]
    end

    files.each do |file|
      file['items'] = Document.find_all_by_path(file['path']).map(&:item)
    end

    files
  end
end