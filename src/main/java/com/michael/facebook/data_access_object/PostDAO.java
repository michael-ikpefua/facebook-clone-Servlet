package com.michael.facebook.data_access_object;

import com.michael.facebook.model.Post;
import com.michael.facebook.model.User;
import com.michael.facebook.services.DB;
import com.michael.facebook.utilities.CurrentDateTime;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {

    public void addPost(Post post) {
        try(Connection connection = DB.connect();
            PreparedStatement preparedStatement = connection.prepareStatement("insert into posts(user_id, body, created_at) values (?,?,?)");
        ) {
            preparedStatement.setInt(1, post.getUser_id());
            preparedStatement.setString(2, post.getBody());
            preparedStatement.setString(3, CurrentDateTime.now());

            preparedStatement.executeUpdate();

        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    public List<Post> fetchAllPosts()
    {
        ArrayList<Post> posts = new ArrayList<>();
        try(Connection connection = DB.connect();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * from posts ORDER BY created_at DESC ");
        ) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                int userId = resultSet.getInt("user_id");
                String body = resultSet.getString("body");
                Timestamp createdAt = resultSet.getTimestamp("created_at");
                posts.add(new Post(id, userId, body, createdAt));
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }

        return posts;
    }

}
