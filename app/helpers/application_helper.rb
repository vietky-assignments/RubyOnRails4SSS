module ApplicationHelper

    def current_user?(user)
        user == current_user
    end

    def user_link(user)
        link_to user.email, user_path(:id => user.id)
    end
end
