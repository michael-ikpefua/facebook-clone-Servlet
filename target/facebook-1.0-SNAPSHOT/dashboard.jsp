<%@ page import="com.michael.facebook.model.User" %>
<%@ page import="java.awt.*" %>
<%@ page import="com.michael.facebook.model.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.michael.facebook.data_access_object.PostDAO" %>
<%@ page import="com.michael.facebook.data_access_object.UserDAO" %>
<%@ page import="com.michael.facebook.model.Comment" %>
<%@ page import="com.michael.facebook.data_access_object.CommentDAO" %>
<%@include file="includes/header.jsp"%>
<%@include file="includes/nav.jsp"%>

<div class="container">

    <div class="row">
        <div class="col-lg-3">
            <div class="shadow p-3 mb-5 bg-body rounded text-center">
                <img class="profile-pic-icon-three mt-4" src="assets/images/avatar.png" alt="">
                <h5 class="mt-3"><%
                    User user = null;
                    if (request.getSession().getAttribute("user_session") != null) {
                        user = (User) request.getSession().getAttribute("user_session");
                        out.print(user.getName());
                    }
                %>
                </h5>
                <p>
                    Date Added: <%= user.getCreatedAt() %>
                <p>
            </div>
        </div>
        <div class="col-lg-9">

            <div class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <%
                    if(request.getParameter("is_deleted") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Post Deleted Successfully from our system.
                    </div>
                    <%
                        }
                    %>
                    <form action="<%=request.getContextPath()%>/post" method="post">
                        <input type="hidden" name="page" value="add">
                        <div class="col-lg-11 text-right">
                            <textarea class="form-control drag" name="body" placeholder="write a post" ></textarea>

                            <button class="btn btn-primary btn-md mt-3 btn-block" type="submit">Post</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="row">
                <div><h4 class="mb-4">Posts</h4></div>
            </div>

            <%
                ArrayList<Post> posts = (ArrayList<Post>) request.getAttribute("posts");
                if(posts.size() == 0){
            %><h4 style="text-align: center; color: #ffffff;">No Posts was made</h4><%
            }
            for(Post post: posts){
        %>
            <div id="section-one" class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <div class="col-lg-1">
                        <img class="profile-pic-icon-two" src="/assets/images/avatar.png" />
                    </div>
                    <div class="col-lg-11">
                        <h5 class="postName">
                            <%
                                User user1 = (new UserDAO().getUserById(post.getUser_id()));
                            %>
                            <a href="<%=request.getContextPath()%>/comment?post_id=<%=post.getId()%>">
                                <%= user1.getName() %>
                            </a>
                        </h5>
                        <b>

                        </b>
                        <h6 class="card-subtitle mb-2 text-muted"><%= post.getBody() %></h6>
                        <p class="post-date"><%= post.getCreatedAt() %></p>
                        <div>
                            <a href="<%=request.getContextPath()%>/comment?post_id=<%=post.getId()%>">
                                Add Comments.
                            </a>
                        </div>

                    </div>

                </div>
            </div>
            <%
                }
            %>

        </div>

    </div>
</div>

<footer class="text-center mt-5 mb-5">Michael FaceBook  Corporation- 2021</footer>

<%@include file="/includes/footer.jsp" %>
