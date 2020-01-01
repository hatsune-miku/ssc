require 'fileutils'


STORAGE_PATH = '/Users/kagaminerin/Desktop/ssc/'.freeze

class UploadController < ApplicationController
    def create
        index
    end

    def index
        file = params[:file]
        if file
            FileUtils.cp file.path, "#{STORAGE_PATH}#{file.original_filename}"

            loli = Lollipop.find_by name: file.original_filename
            if loli
                render json: { error: '文件已经存在' }
            else
                Lollipop.create(name: file.original_filename, count: 0)
                render json: { error: nil }
            end

        else
            head 404

        end
    end

    def show
        case params[:id]
        when 'list'
            render json: []
            return

h-            lolis = Lollipop.all
            ret = []
            Dir.foreach(STORAGE_PATH) do |file|
                next if file.first == '.' or file.index('~$') == 0 or File.directory?("#{STORAGE_PATH}#{file}")
                f = File.open("#{STORAGE_PATH}#{file}")

                loli = lolis.where name: file # Lollipop.find_by name: file

                ret << { name: file, count: loli ? loli.count : 0, mtime: f.mtime.to_s, size: f.size }
            end
            render json: ret

        when 'delete'
            FileUtils.rm "#{STORAGE_PATH}#{params[:filename]}"
            Lollipop.find_by(name: params[:filename]).destroy
            render json: { error: nil }

        when 'pick'
            file = params[:filename]

            if File.exists?("#{STORAGE_PATH}#{file}")
                loli = Lollipop.find_by name: file
                if loli
                    loli.update count: loli.count + 1
                else
                    Lollipop.create(name: file, count: 1)
                end
                send_file "#{STORAGE_PATH}#{file}"
                # send_data File.read("#{STORAGE_PATH}#{file}"), filename: file
            else

                head 404
            end

        else
            head 404
        end
    end
end
