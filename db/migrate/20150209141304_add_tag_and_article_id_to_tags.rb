class AddTagAndArticleIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tag, :string
    add_column :tags, :article_id, :integer
  end
end
