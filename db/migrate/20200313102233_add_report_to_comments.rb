class AddReportToComments < ActiveRecord::Migration[6.0]
  def change
  	add_column :comments, :report, :boolean, default:false
  end
end
