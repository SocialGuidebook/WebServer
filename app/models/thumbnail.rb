class Thumbnail
  def initialize(options = {})
    @url  = options[:url]
    @size = options[:size]
    @fill = true if options[:fill]
  end
  
  def save_file_name
    @fill ? "#{file_hash}.#{@size}.fill.png" : "#{file_hash}.#{@size}.png"
  end
  
  def get_path
    if self.exist?
      save_file_path(false)
    else
      "/thumbnails/#{@size}?u=#{CGI.escape @url}#{@fill ? '&fill=1' : ''}"
    end
  end
  
  def save_file_path(root_path = true)
    base = root_path ? "#{RAILS_ROOT}/public" : ""
    "#{base}/thumbs/#{save_file_name}"
  end
  
  def exist?
    return File.exist?(save_file_path) && File.size(save_file_path) > 0
  end
  
  def file_hash
    Digest::MD5.hexdigest(@url)
  end
  
  def original_name
    "#{RAILS_ROOT}/public/thumbs/#{file_hash}.original.png"
  end
  
  def url
    file_name = save_file_name
    file_path = "#{RAILS_ROOT}/public/thumbs/#{file_name}"
    if File.exist?(file_path) && File.size(file_path) > 0
      return "/thumbs/#{file_name}"
    end
    begin
      if File.exist?(original_name) && File.size(original_name) > 0
        image_path = original_name
      else
        image = open(@url).read
        fp = File.new(original_name, "w")
        fp.write(image)
        fp.close
        image_path = original_name
      end
      
      if @fill
        convert_path = "#{RAILS_ROOT}/public/thumbs/#{save_file_name}"
        cmd = "#{settings["convert"]} #{image_path} -resize #{@size}x#{@size}\\> -size #{@size}x#{@size} xc:white +swap -gravity center -composite #{convert_path}"
        `#{cmd}`
      else
        img = ImageScience.with_image(image_path) do |img|
          img.thumbnail(@size) do |thumb|
            thumb.save(file_path)
          end
        end
      end
    rescue
    end
    return "/thumbs/#{file_name}"
  end
  
  def settings
    @settings ||= YAML.load_file("#{Rails.root}/config/settings.yml")[RAILS_ENV]
  end
  
  def get_size
    ImageScience.with_image(save_file_path) do |img|
      return [img.width, img.height]
    end
  end
end
