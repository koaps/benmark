class InsertTests < Sequel::Migration

  def up
    self[:tests].insert(:item => 'Test items 1')
    self[:tests].insert(:item => 'Test items 2')
    self[:tests].insert(:item => 'Test items 3')
    self[:tests].insert(:item => 'Test items 4')
  end

  def down
    self["DELETE FROM tests WHERE item like '%items%'"].delete
  end
end
