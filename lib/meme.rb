class Meme

    def initialize(path_to_temp, upper_text, lower_text)

        @path_to_temp = path_to_temp
        @upper_text = Text_info.new(modify_text(upper_text), set_point_size(upper_text))
        @lower_text = Text_info.new(modify_text(lower_text), set_point_size(lower_text))
        @text_color = 'white'
        @text_font = 'Helvetica'

    end

    def store_meme
        image = make_meme
        storage = set_storage

        case Rails.env 
           when 'production'
            # need to change image name later
            bucket = storage.directories.get(ENV['AWS_BUCKET'])
            png_path = ENV['AWS_PRO_FOLDER']+ '/' + rand(1..1000).to_s + '.png'
            image_uri = image.path 
            file = bucket.files.create(key: png_path, public: true, body: open(image_uri))
            return 'https://s3-ap-northeast-1.amazonaws.com/' + ENV['AWS_BUCKET'] + '/' + png_path
           when 'development'
            bucket = storage.directories.get(ENV['AWS_BUCKET'])
            png_path = ENV['AWS_DEV_FOLDER'] + '/' + rand(1..1000).to_s + '.png'
            image_uri = image.path 
            file = bucket.files.create(key: png_path, public: true, body: open(image_uri))
            return 'https://s3-ap-northeast-1.amazonaws.com/' + ENV['AWS_BUCKET'] + '/' + png_path
        end

    end


    private 
        def make_meme

            image = MiniMagick::Image.open(@path_to_temp)

            # draw upper text in the image
            image.combine_options do |i|
                i.font @text_font
                i.fill @text_color
                i.pointsize @upper_text.pointsize
                i.draw "text 0,0 '#{@upper_text.text}'"
            end

            # draw lower text in the image
            image.combine_options do |i|
                i.font @text_font
                i.fill @text_color
                i.pointsize @lower_text.pointsize
                i.draw "text 0,500 '#{@lower_text.text}'"
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

        def modify_text(text)

            if text.length <  15
              text
            else
              modified_text = text[0..15]
              modified_text < '\n'
              modified_text < text[16..30]
              modified_upper_text = text_info.new(@upper_text, )
              modified_text
            end

        end

        def set_point_size(text)

            if text.length < 15
                return 120
            else
                return 80
            end

        end

        Text_info = Struct.new(:text, :pointsize)

end