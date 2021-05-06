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
            PostDAO postDAO = new PostDAO();
            postDAO.addPost(post);
            response.sendRedirect(request.getContextPath()+"/dashboard");
        }
    }


}

