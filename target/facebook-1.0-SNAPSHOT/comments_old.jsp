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
        <div class="col-lg-6">

            <div class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <div class="col-lg-1">
                        <img class="profile-pic-icon-two" src="images/edema.jpeg" alt="">
                    </div>
                    <form action="<%=request.getContextPath()%>/post" method="post">
                        <input type="hidden" name="page" value="add">
                        <div class="col-lg-11 text-right">
                            <textarea class="form-control drag" name="body" placeholder="write a post"></textarea>
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
            for(int i=0; i<posts.size(); i++){
        %>
            <div id="section-one" class="shadow p-3 mb-5 bg-body rounded">
                <div class="row">
                    <div class="col-lg-1">
                        <img class="profile-pic-icon-two" src="/assets/images/avatar.png" />
                    </div>
                    <div class="col-lg-11">
                        <h5 class="postName">
                            <%
                                User user1 = (new UserDAO().getUserById(posts.get(i).getUser_id()));
                                out.print(user1.getName());
                            %>
                        </h5>
                        <b>

                        </b>
                        <h6 class="card-subtitle mb-2 text-muted"><%= posts.get(i).getBody() %></h6>
                        <p class="post-date"><%= posts.get(i).getCreatedAt() %></p>
                        <form action="<%=request.getContextPath()%>/comment" method="post">
                            <input type="hidden" name="post_id" value="<%= posts.get(i).getId() %>">
                            <div class="row">
                                <div class="col-lg-10">
                                    <input type="text" name="body" class="form-control comment-form">
                                </div>
                                <div class="col-lg-2">
                                    <button type="submit" class="btn btn-primary btn-sm btn-block">Comment</button>
                                </div>
                            </div>
                        </form>
                        <%
                            CommentDAO commentDAO = new CommentDAO();
                            ArrayList<Comment> comments = commentDAO.getCommentsByPostId(posts.get(i).getId());
                            if (comments.size() == 0) {
                                out.print("");
                            }
                            else {
                                for(Comment comment: comments) {
                        %>
                        <p><%= comment.getBody() %></p>
                        <%
                                }
                            }
                        %>

                    </div>

                </div>
            </div>
            <%
                }
            %>

        </div>
        <div class="col-lg-3">
            <div class="shadow p-3 mb-5 bg-body rounded">
                <h4>Activity</h4>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <nav aria-label="...">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item" aria-current="page">
                    <a class="page-link" href="#">2</a>
                </li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</div>
<footer class="text-center mt-5 mb-5">Java Book - 2021</footer>
<script type="text/javascript">
    function removesection_one(){
        document.getElementById('section-one').remove();
    }
    function removesection_two(){
        document.getElementById('section-two').remove();
    }
    function removesection_three(){
        document.getElementById('section-three').remove();
    }
</script>


<%@include file="/includes/footer.jsp" %>
