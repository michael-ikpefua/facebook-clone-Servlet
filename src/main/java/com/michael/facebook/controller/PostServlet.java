package com.michael.facebook.controller;

import com.michael.facebook.data_access_object.PostDAO;
import com.michael.facebook.model.Post;
import com.michael.facebook.model.User;
import com.michael.facebook.services.DB;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PostServlet", value = "/post")
public class PostServlet extends HttpServlet {
    PostDAO postDAO = null;
    public PostServlet() {
        postDAO = new PostDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("page");
        switch (page) {
            case "add":
                addPost(request, response);
                break;
            case "update_post":
                updatePost(request, response);
            default:
                break;
        }
    }

    protected void addPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String  body = request.getParameter("body");
        User user = (User) request.getSession().getAttribute("user_session");
        boolean isError = false;

        if (body == null || body == "") {
            request.setAttribute("bodyValidation", "field is required!");
            isError = true;
        } else {
//            response.getWriter().println(user.getId());
            Post post = new Post(user.getId(), body);
            postDAO.addPost(post);
            response.sendRedirect(request.getContextPath()+"/dashboard");
        }

    }

    protected void updatePost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User authUser = (User) request.getSession().getAttribute("user_session");
        int postId =Integer.parseInt(request.getParameter("post_id"));
        int postAuthorId = Integer.parseInt(request.getParameter("post_author_id"));
        String body = request.getParameter("body");

        if (body.equals("")) {
            request.setAttribute("bodyValidation", "field is required!");
        } else if(authUser.getId() != postAuthorId) {
            request.setAttribute("access_deny", "You dont have access to update this post");
        }
        else {
            boolean isUpdate = postDAO.updatePost(postId, body);
            if(!isUpdate) {
                response.getWriter().println("Something went wrong in database");
            } else {
                request.getSession().setAttribute("update_successful", "Post Updated Successful");
                response.sendRedirect(request.getContextPath()+"/comment?post_id="+postId);
            }
        }
    }


    }

