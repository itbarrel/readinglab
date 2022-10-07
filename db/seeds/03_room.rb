# frozen_string_literal: true

Room.find_or_create_by!(name: 'room 1', capacity: 22, account: Account.last)
