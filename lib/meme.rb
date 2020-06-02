class Meme

    def initialize(path_to_temp, upper_text, lower_text)

        @path_to_temp = path_to_temp
        @upper_text = upper_text
        @lower_text = lower_text
        @text_color = 'white'
        @text_font = 'Helvetica'
        @text_pointsize = ""
        @draw = ""

    end

    


    def store_meme
        image = make_meme
        storage = set_storage

        case Rails.env 
           when 'production'
            bucket = storage.directories.get(ENV['AWS_BUCKET'])
            png_path = ENV['AWS_PRO_FOLDER']+ '/' + id.to_s + '.png'
            image_uri = image.path 
            file = bucket.files.create(key: png_path, public: true, body: open(image_uri))
            return 'https://s3-ap-northeast-1.amazonaws.com/' + ENV['AWS_BUCKET'] + '/' + png_path
           when 'development'
            bucket = storage.directories.get(ENV['AWS_BUCKET'])
            png_path = ENV['AWS_DEV_FOLDER'] + '/' + id.to_s + '.png'
            image_uri = image.path 
            file = bucket.files.create(key: png_path, public: true, body: open(image_uri))
            return 'https://s3-ap-northeast-1.amazonaws.com/' + ENV['AWS_BUCKET'] + '/' + png_path
        end

    end


    private 
        def make_meme

            image = MiniMagick::Image.new(path_to_temp)

            image.combine_options do |i|
                i.font @text_font
                i.fill @text_color
                i.pointsize @pointsize
                i.draw "text 0,0 '{@upper_text}'"
                i.draw "text 0,#{image[width].to_i * 0.8} '#{@lower_text}'"
            end

        end


        def set_storage

            Fog::Storage.new(
                provider: 'AWS',
                aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                region: ENV['AWS_REGION']
            )

        end

end