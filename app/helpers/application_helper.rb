module ApplicationHelper
  def upvote_class
    if current_user
      ["upvote", current_user.vote_products.include?(@product) ? "voted" : nil ].compact.join(" ")
    else
      "upvote"
    end
  end

  def id_upvote
    @id_upvote = upvote_class.split(/\s/).join("_")
  end
end
