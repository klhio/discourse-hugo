# name: hugo
# about: Generate static pages from forum posts
# version: 0.0.1
# authors: Maciej Sopyło
# url: https://github.com/klhio/discourse-hugo

def export_post(p)
  topic = Topic.find_by(id: p.topic_id)
  post = topic.first_post
  tag_list = topic.tags.map{|tag| "'#{tag.name}'"}.join(',')
  File.open("/var/www/discourse/public/hugo/content/post/#{topic.slug}.html", 'w') { |file|
    file.write("---\n")
    file.write("title: \"#{topic.title}\"\n")
    file.write("date: #{post.created_at}\n")
    file.write("tags: [#{tag_list}]\n")
    file.write("---\n\n")
    file.write(post.cooked)
  }
end

after_initialize do
  # topic_created
  # topic_destroyed
  # topic_recovered
  # username_changed
  # user_updated
  %i(
    post_created
    post_destroyed
    post_edited
  ).each do |event|
    DiscourseEvent.on(event) do |post, _, _|
      export_post(post)
    end
  end
end