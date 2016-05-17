class Relationship < ActiveRecord::Base
  # follower と followed はUserクラスのオブジェクトなので、
  # class_name で User を指定する
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
