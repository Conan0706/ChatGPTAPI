class CreateMemoTable < ActiveRecord::Migration[6.1]
  def change
    create_table :memos do |t|
      t.string :title
      t.text :body
    end
  end
end
