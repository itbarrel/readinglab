class CreatePaymentMeetings < ActiveRecord::Migration[7.0]
  def change

    create_table :payment_meetings, id: :uuid do |t|

          t.references :payment, null: false, foreign_key: true, type: :uuid
          t.references :meeting, null: false, foreign_key: true, type: :uuid
    
          t.timestamps
          t.datetime :deleted_at  
    end
  end
end
