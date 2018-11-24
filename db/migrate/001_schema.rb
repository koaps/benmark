Sequel.migration do

  up do
    create_table(:tests) do
      primary_key :id, type:Integer
      String :item
    end
  end

  down do
    drop_table(:tests)
  end

end
