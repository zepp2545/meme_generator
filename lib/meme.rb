class Meme

    def initialize(path_to_temp, upper_text, lower_text)

        @path_to_temp = path_to_temp
        @upper_text = Text_info.new(modify_text(upper_text), set_point_size(upper_text), 'North')
        @lower_text = Text_info.new(modify_text(lower_text), set_point_size(lower_text), 'South')
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

            image = MiniMagick::Image.new(@path_to_temp)

            # draw upper text in the image
            image.combine_options do |i|
                i.font @text_font
                i.fill @text_color
                i.pointsize @upper_text.pointsize
                i.gravity @upper_text.gravity
                i.draw "text 0,0 '#{@upper_text.text}'"
            end

            # draw lower text in the image
            image.combine_options do |i|
                i.font @text_font
                i.fill @text_color
                i.pointsize @lower_text.pointsize
                i.gravity @lower_text.gravity
                i.draw "text 0,0 '#{@lower_text.text}'"
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

            text = text.split
            rows = text.size % 4 + 1

            if rows > 1
              text.each_with_index.reduce("") do |string, (element, index)|
                if index % 4 =~ /^[0-9]$/
                  string += element + "\n"
                else
                  string += element + " "
                end
              end
            elsif rows = 1
              text.join(' ')
            end

        end

        def set_point_size(text)

            text = text.split
            rows = text.size % 4 + 1

            if rows >= 3
                return 80
            elsif rows == 2
                return 100
            else
                return 150
            end

        end

        Text_info = Struct.new(:text, :pointsize, :gravity)

end