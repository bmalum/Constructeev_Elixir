# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Constructeev.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Faker.start
alias Constructeev.Repo

defmodule ChannelGenerator do 

def channel_loop(0) do
IO.puts "Finish"
end

def channel_loop(loops) do
  loops = loops - 1;
    channel = Repo.insert! %Constructeev.Channel{name: Faker.App.name,
                                                 description: Faker.Lorem.Shakespeare.hamlet,
                                                 email: Faker.Internet.email,
                                                 feedback_counter: 100,
                                                 likes: 2*loops
                                                }
    Map.get(channel, :id)
    |> feedback_loop(100)
    channel_loop(loops)
end

def feedback_loop(_, 0) do
  IO.puts "FINISH"
end

def feedback_loop(channel_id, loops) do
  loops = loops - 1
  feedback = Repo.insert! %Constructeev.Feedback{channel_id: channel_id,
                                                 title: Faker.Lorem.sentence(3),
                                                 author: Faker.Name.name,
                                                 content: Faker.Lorem.Shakespeare.hamlet,
                                                 happiness: 0}
  id =  Map.get(feedback, :id)
  Repo.insert! %Constructeev.FeedbackProperty{ feedback_id: id,
                                               channel_id: channel_id}
  feedback_loop(channel_id, loops)
end
end 

ChannelGenerator.channel_loop(100)
