class Message < ApplicationRecord
  acts_as_readable :on => :created_at

  # ensure that all messages are sorted in ascending order
  default_scope { order(created_at: :asc) }
  belongs_to :chatroom
  belongs_to :user
  has_many :notifications, dependent: :destroy
  #something about user?

  mount_uploader :imagemessage, ImageMessageUploader

  validates :content, presence: true, length: {minimum: 1}

  def notify
    @receivingUsers = User.where(id: self.chatroom.users.map(&:id)).where.not(id: self.user.id)
    @receivingUsers.each do |user|
      @notification = Notification.create(:message_id => self.id,
                                          :event => "#{self.user.username} posted a new message in #{self.chatroom.roomname}.",
                                          :user_id => user.id)
      self.notifications << @notification
    end
  end
end
