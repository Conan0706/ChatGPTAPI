require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'

require 'net/http'
require 'json'
require 'openai'
require 'dotenv'

Dotenv.load

enable :sessions

get '/' do
    @answer = session[:result]
    
    if !Memo.nil?
        puts "hoge"
        @memos = Memo.all
    end
  erb :index
end

post "/question" do
    # APIアクセス
    client = OpenAI::Client.new(access_token: "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")
    
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: params[:question] }], # Required.
        temperature: 0.7,
    })
    resDig = response.dig("choices", 0, "message", "content")
    result = resDig.gsub(/\。/, "。<br>") 
    
    session[:result] = result
    
    redirect "/"
end

post "/memoFromAPI" do
   Memo.create(
       title: params[:title],
       body: params[:content]
       ) 
      redirect "/"
end


